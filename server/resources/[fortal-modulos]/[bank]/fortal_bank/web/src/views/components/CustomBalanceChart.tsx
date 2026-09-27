import React, { useState, useMemo, useEffect } from "react";
import { fetchNui } from "../../app/utils/fetchNui";
import { useSelectedAccount } from "../../hooks/useSelectedAccount";

// Declaração de tipos para window
declare global {
  interface Window {
    refreshBalanceChart?: () => void;
  }
}

interface ChartData {
  day: string;
  value: number;
}

interface BalanceHistoryData {
  period_value: string;
  balance: number;
}

interface BalanceChartProps {
  className?: string;
}

type PeriodFilter = "weekly" | "monthly";

const CustomBalanceChart: React.FC<BalanceChartProps> = ({ className }) => {
  const [selectedPeriod, setSelectedPeriod] = useState<PeriodFilter>("weekly");
  const [chartData, setChartData] = useState<ChartData[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();

  const loadChartData = async (period: PeriodFilter) => {
    try {
      setLoading(true);
      console.log('CustomBalanceChart: Carregando dados para período:', period, 'conta:', selectedAccount);
      
      const result: BalanceHistoryData[] = await fetchNui('getBalanceHistory', { 
        period,
        accountType: isJointAccount ? 'joint' : 'personal',
        // Para conta pessoal não enviar accountId para evitar filtro indevido no servidor
        accountId: isJointAccount ? selectedAccount?.id : undefined
      });
      console.log('CustomBalanceChart: Dados recebidos do servidor:', result);
      
      // Converter dados do servidor para formato do gráfico
      const formattedData = formatServerData(result, period);
      console.log('CustomBalanceChart: Dados formatados:', formattedData);
      
      setChartData(formattedData);
    } catch (error) {
      console.error('Erro ao carregar dados do gráfico:', error);
      // Fallback para dados mockados
      console.log('CustomBalanceChart: Usando dados mockados como fallback');
      setChartData(generateData(period));
    } finally {
      setLoading(false);
    }
  };

  const formatServerData = (serverData: BalanceHistoryData[], period: PeriodFilter): ChartData[] => {
    console.log('formatServerData: Dados recebidos:', serverData, 'Período:', period);

    // Normalizar tipos e ordenar por período
    const normalized = (serverData || []).map(d => ({
      ...d,
      balance: typeof d.balance === 'string' ? Number(d.balance) : (d.balance || 0)
    })).sort((a, b) => (a.period_value < b.period_value ? -1 : 1));

    // Pega o último saldo conhecido até uma chave (data/semana)
    const getLastKnown = (key: string) => {
      const past = normalized.filter(d => d.period_value <= key);
      return past.length > 0 ? past[past.length - 1].balance : 0;
    };

    switch (period) {
      case "weekly":
        const weekLabels = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
        return Array.from({ length: 7 }, (_, i) => {
          const today = new Date();
          const dayOfWeek = today.getDay(); // 0 = Domingo, 1 = Segunda, etc.

          // Calcular a data para cada dia da semana
          const targetDate = new Date(today);
          targetDate.setDate(today.getDate() - dayOfWeek + i);

          const dateStr = targetDate.toISOString().split('T')[0];

          // Se dia é futuro, manter 0
          const isFuture = targetDate > today;

          // Registro exato
          const exact = normalized.find(d => d.period_value === dateStr);

          // Se não há registro e o dia é antes ou igual ao hoje,
          // usar o saldo da data mais próxima no futuro DENTRO da semana (forward-fill)
          const forwardWithinWeek = () => {
            for (let j = i; j < 7; j++) {
              const d = new Date(today);
              d.setDate(today.getDate() - dayOfWeek + j);
              const k = d.toISOString().split('T')[0];
              const found = normalized.find(x => x.period_value === k);
              if (found) return found.balance;
            }
            return getLastKnown(dateStr);
          };

          const value = isFuture
            ? 0
            : exact
              ? exact.balance
              : forwardWithinWeek();

          console.log('Buscando dia da semana:', weekLabels[i], dateStr, 'Valor usado:', value);

          return {
            day: weekLabels[i],
            value
          };
        });

      case "monthly":
        const monthWeekLabels = ["Sem 1", "Sem 2", "Sem 3", "Sem 4"];
        return Array.from({ length: 4 }, (_, i) => {
          const now = new Date();
          const currentWeekOfMonth = Math.ceil(now.getDate() / 7);

          // Semana do mês (1-4)
          const weekOfMonth = i + 1;
          const monthKey = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-W${weekOfMonth}`;

          // Futuro dentro do mês => 0
          const isFuture = weekOfMonth > currentWeekOfMonth;

          // Registro exato
          const exact = normalized.find(d => d.period_value === monthKey);

          // Se não há registro e a semana é anterior/igual à atual,
          // procurar a próxima semana deste mês com registro (forward-fill);
          // se não houver, usar último saldo conhecido anterior
          const forwardWithinMonth = () => {
            for (let j = weekOfMonth; j <= 4; j++) {
              const key = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-W${j}`;
              const found = normalized.find(x => x.period_value === key);
              if (found) return found.balance;
            }
            return getLastKnown(monthKey);
          };

          const value = isFuture
            ? 0
            : exact
              ? exact.balance
              : forwardWithinMonth();

          console.log('Buscando semana do mês:', monthKey, 'Valor usado:', value);

          return {
            day: monthWeekLabels[i],
            value
          };
        });

      default:
        return [];
    }
  };

  const generateData = (period: PeriodFilter): ChartData[] => {
    switch (period) {
      case "weekly":
        return [
          { day: "Dom", value: 600000 },
          { day: "Seg", value: 200000 },
          { day: "Ter", value: 180000 },
          { day: "Qua", value: 50000 },
          { day: "Qui", value: 0 },
          { day: "Sex", value: 0 },
          { day: "Sáb", value: 0 },
        ];
      case "monthly":
        return [
          { day: "Sem 1", value: 450000 },
          { day: "Sem 2", value: 320000 },
          { day: "Sem 3", value: 580000 },
          { day: "Sem 4", value: 200000 },
        ];
      default:
        return [];
    }
  };

  useEffect(() => {
    loadChartData(selectedPeriod);
  }, [selectedPeriod, selectedAccount]);

  // Expor função para atualizar o gráfico
  useEffect(() => {
    window.refreshBalanceChart = () => loadChartData(selectedPeriod);
    return () => {
      window.refreshBalanceChart = undefined;
    };
  }, [selectedPeriod, selectedAccount, isPersonalAccount, isJointAccount]);

  const maxValue = useMemo(() => {
    const max = Math.max(...chartData.map((item) => item.value));
    return max > 0 ? max : 1;
  }, [chartData]);

  const formatValue = (value: number) => {
    if (value >= 1000000) {
      return `${(value / 1000000).toFixed(1)}M`;
    } else if (value >= 1000) {
      return `${(value / 1000).toFixed(0)}K`;
    }
    return value.toString();
  };

  const periodLabels = {
    weekly: "Semanal",
    monthly: "Mensal",
  };

  const getBarHeight = (value: number) => {
    return Math.max((value / maxValue) * 100, value > 0 ? 2 : 0);
  };

  return (
    <div
      className={`flex flex-col rounded-md p-6 h-[17.5rem] ${className}`}
      style={{
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
      }}
    >
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-2">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width=".75rem"
            height=".625rem"
            viewBox="0 0 12 10"
            fill="none"
          >
            <path
              d="M8.8 3.18182C8.8 2.93078 8.59264 2.72727 8.33685 2.72727H6.94737C6.69158 2.72727 6.48421 2.93078 6.48421 3.18182V9.54545C6.48421 9.79649 6.69158 10 6.94737 10H8.33685C8.59264 10 8.8 9.79649 8.8 9.54545V3.18182Z"
              fill="white"
              fill-opacity="0.25"
            />
            <path
              d="M5.5579 5.45455C5.5579 5.20351 5.35053 5 5.09474 5H3.70527C3.44947 5 3.24211 5.20351 3.24211 5.45455V9.54545C3.24211 9.79649 3.44947 10 3.70527 10H5.09474C5.35053 10 5.5579 9.79649 5.5579 9.54545V5.45455Z"
              fill="white"
              fill-opacity="0.25"
            />
            <path
              d="M2.31579 8.18182C2.31579 7.93078 2.10843 7.72727 1.85263 7.72727H0.463158C0.207363 7.72727 0 7.93078 0 8.18182V9.54545C0 9.79649 0.207363 10 0.463158 10H1.85263C2.10843 10 2.31579 9.79649 2.31579 9.54545V8.18182Z"
              fill="white"
              fill-opacity="0.25"
            />
            <path
              d="M12 0.454545C12 0.203507 11.7926 0 11.5368 0H10.1474C9.89157 0 9.68421 0.203507 9.68421 0.454545V9.54545C9.68421 9.79649 9.89157 10 10.1474 10H11.5368C11.7926 10 12 9.79649 12 9.54545V0.454545Z"
              fill="white"
              fill-opacity="0.25"
            />
          </svg>
          <h3 className="text-white/40 text-sm font-normal">Balanço</h3>
        </div>

        <div className="flex items-center gap-1 p-1 rounded-md bg-white/[0.05]">
          {(Object.keys(periodLabels) as PeriodFilter[]).map((period) => (
            <button
              key={period}
              onClick={() => setSelectedPeriod(period)}
              className={`px-3 py-1.5 text-xs font-medium rounded transition-all ${
                selectedPeriod === period
                  ? "bg-[#df5454] text-white"
                  : "text-white/60 hover:text-white/80"
              }`}
            >
              {periodLabels[period]}
            </button>
          ))}
        </div>
      </div>

      <div className="relative flex-1 flex items-end justify-between">
        <div className="absolute left-0 top-0 h-full flex flex-col justify-between text-xs text-white/40 w-10">
          <span className="text-right">{formatValue(maxValue)}</span>
          <span className="text-right">
            {formatValue(Math.round(maxValue * 0.75))}
          </span>
          <span className="text-right">
            {formatValue(Math.round(maxValue * 0.5))}
          </span>
          <span className="text-right">
            {formatValue(Math.round(maxValue * 0.25))}
          </span>
          <span className="text-right">0</span>
        </div>

        <div className="flex-1 ml-12 h-full flex flex-col">
          <div className="flex-1 flex items-end justify-between gap-1 pb-3">
            {chartData.map((item, index) => (
              <div
                key={index}
                className="flex flex-col items-center flex-1 group h-full"
              >
                <div className="w-full max-w-12 flex flex-col justify-end relative flex-1">
                  <div
                    className="w-full bg-gradient-to-t from-[#df5454] to-[#5BB3F5] rounded-t-md transition-all duration-700 ease-out shadow-lg relative overflow-hidden"
                    style={{
                      height: `${getBarHeight(item.value)}%`,
                      minHeight: item.value > 0 ? "3px" : "0px",
                      boxShadow:
                        item.value > 0
                          ? "0 -4px 12px rgba(60, 142, 220, 0.3)"
                          : "none",
                    }}
                  >
                    {item.value > 0 && (
                      <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent opacity-50" />
                    )}

                    <div className="absolute -top-10 left-1/2 transform -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-all duration-200 bg-black/90 text-white text-xs px-2 py-1 rounded whitespace-nowrap z-10 shadow-lg">
                      ${formatValue(item.value)}
                      <div className="absolute top-full left-1/2 transform -translate-x-1/2 w-0 h-0 border-l-2 border-r-2 border-t-4 border-l-transparent border-r-transparent border-t-black/90"></div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
          <div className="flex items-center justify-between gap-1">
            {chartData.map((item, index) => (
              <div key={index} className="flex-1 text-center">
                <span className="text-xs text-white/60 font-medium">
                  {item.day}
                </span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default CustomBalanceChart;
