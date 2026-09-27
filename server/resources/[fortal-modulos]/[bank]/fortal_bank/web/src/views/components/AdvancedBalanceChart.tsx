import React, { useState, useEffect, useMemo } from "react";
import { Calendar, TrendingUp, TrendingDown, BarChart3 } from "lucide-react";

interface ChartData {
  period: string;
  value: number;
  date?: string;
}

interface AdvancedBalanceChartProps {
  className?: string;
  onPeriodChange?: (period: PeriodFilter) => void;
  onDataRequest?: (
    period: PeriodFilter,
    startDate: string,
    endDate: string
  ) => Promise<ChartData[]>;
}

type PeriodFilter = "daily" | "weekly" | "monthly";

const AdvancedBalanceChart: React.FC<AdvancedBalanceChartProps> = ({
  className,
  onPeriodChange,
  onDataRequest,
}) => {
  const [selectedPeriod, setSelectedPeriod] = useState<PeriodFilter>("weekly");
  const [chartData, setChartData] = useState<ChartData[]>([]);
  const [loading, setLoading] = useState(false);
  const [dateRange, setDateRange] = useState({
    start: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000)
      .toISOString()
      .split("T")[0],
    end: new Date().toISOString().split("T")[0],
  });

  const getDefaultData = (period: PeriodFilter): ChartData[] => {
    const now = new Date();

    switch (period) {
      case "daily":
        return Array.from({ length: 7 }, (_, i) => {
          const date = new Date(now);
          date.setDate(date.getDate() - (6 - i));
          const dayNames = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
          const values = [600000, 520000, 180000, 160000, 50000, 0, 0];
          return {
            period: dayNames[date.getDay()],
            value: values[i] || Math.random() * 500000,
            date: date.toISOString().split("T")[0],
          };
        });

      case "weekly":
        return Array.from({ length: 7 }, (_, i) => {
          const weekStart = new Date(now);
          weekStart.setDate(
            weekStart.getDate() - (weekStart.getDay() + (6 - i) * 7)
          );
          const values = [600000, 200000, 180000, 50000, 0, 0, 0];
          return {
            period: `Sem ${i + 1}`,
            value: values[i] || Math.random() * 400000,
            date: weekStart.toISOString().split("T")[0],
          };
        });

      case "monthly":
        return Array.from({ length: 12 }, (_, i) => {
          const month = new Date(now.getFullYear(), i, 1);
          const monthNames = [
            "Jan",
            "Fev",
            "Mar",
            "Abr",
            "Mai",
            "Jun",
            "Jul",
            "Ago",
            "Set",
            "Out",
            "Nov",
            "Dez",
          ];
          const values = [
            450000, 320000, 580000, 200000, 100000, 350000, 480000, 220000,
            150000, 380000, 290000, 520000,
          ];
          return {
            period: monthNames[i],
            value: values[i] || Math.random() * 600000,
            date: month.toISOString().split("T")[0],
          };
        });

      default:
        return [];
    }
  };

  // Carregar dados quando o período ou range de datas mudar
  useEffect(() => {
    const loadData = async () => {
      setLoading(true);
      try {
        if (onDataRequest) {
          const data = await onDataRequest(
            selectedPeriod,
            dateRange.start,
            dateRange.end
          );
          setChartData(data);
        } else {
          // Simular delay de API
          await new Promise((resolve) => setTimeout(resolve, 500));
          setChartData(getDefaultData(selectedPeriod));
        }
      } catch (error) {
        console.error("Erro ao carregar dados do gráfico:", error);
        setChartData(getDefaultData(selectedPeriod));
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, [selectedPeriod, dateRange, onDataRequest]);

  // Cálculos baseados nos dados
  const stats = useMemo(() => {
    if (chartData.length === 0)
      return { max: 0, min: 0, avg: 0, total: 0, trend: 0 };

    const values = chartData.map((item) => item.value);
    const max = Math.max(...values);
    const min = Math.min(...values);
    const total = values.reduce((sum, val) => sum + val, 0);
    const avg = total / values.length;

    // Calcular tendência (comparar primeira metade com segunda metade)
    const firstHalf = values.slice(0, Math.floor(values.length / 2));
    const secondHalf = values.slice(Math.floor(values.length / 2));
    const firstAvg =
      firstHalf.reduce((sum, val) => sum + val, 0) / firstHalf.length;
    const secondAvg =
      secondHalf.reduce((sum, val) => sum + val, 0) / secondHalf.length;
    const trend = ((secondAvg - firstAvg) / firstAvg) * 100;

    return { max, min, avg, total, trend };
  }, [chartData]);

  const formatValue = (value: number) => {
    if (value >= 1000000) {
      return `${(value / 1000000).toFixed(1)}M`;
    } else if (value >= 1000) {
      return `${(value / 1000).toFixed(0)}K`;
    }
    return Math.round(value).toString();
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "USD",
    }).format(value);
  };

  const periodLabels = {
    daily: "Diário",
    weekly: "Semanal",
    monthly: "Mensal",
  };

  const handlePeriodChange = (period: PeriodFilter) => {
    setSelectedPeriod(period);
    if (onPeriodChange) {
      onPeriodChange(period);
    }
  };

  const getBarHeight = (value: number) => {
    return stats.max > 0
      ? Math.max((value / stats.max) * 100, value > 0 ? 2 : 0)
      : 0;
  };

  if (loading) {
    return (
      <div
        className={`flex flex-col rounded-md p-6 ${className}`}
        style={{
          background:
            "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
        }}
      >
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-8 w-8 border-2 border-[#df5454] border-t-transparent"></div>
        </div>
      </div>
    );
  }

  return (
    <div
      className={`flex flex-col rounded-md p-6 ${className}`}
      style={{
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
      }}
    >
      {/* Header com título, filtros e controles de data */}
      <div className="flex flex-col gap-4 mb-6">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BarChart3 size={16} className="text-[#df5454]" />
            <h3 className="text-white/40 text-sm font-normal">Balanço</h3>
          </div>

          {/* Filtros de período */}
          <div className="flex items-center gap-1 p-1 rounded-md bg-white/[0.05]">
            {(Object.keys(periodLabels) as PeriodFilter[]).map((period) => (
              <button
                key={period}
                onClick={() => handlePeriodChange(period)}
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

        {/* Controles de data customizados */}
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-2">
            <Calendar size={14} className="text-white/40" />
            <input
              type="date"
              value={dateRange.start}
              onChange={(e) =>
                setDateRange((prev) => ({ ...prev, start: e.target.value }))
              }
              className="bg-white/5 border border-white/10 rounded px-2 py-1 text-xs text-white/80 focus:outline-none focus:border-[#df5454]"
            />
            <span className="text-white/40 text-xs">até</span>
            <input
              type="date"
              value={dateRange.end}
              onChange={(e) =>
                setDateRange((prev) => ({ ...prev, end: e.target.value }))
              }
              className="bg-white/5 border border-white/10 rounded px-2 py-1 text-xs text-white/80 focus:outline-none focus:border-[#df5454]"
            />
          </div>
        </div>
      </div>

      {/* Estatísticas rápidas */}
      <div className="grid grid-cols-3 gap-4 mb-6">
        <div className="bg-white/5 rounded-md p-3">
          <div className="text-white/60 text-xs">Total</div>
          <div className="text-white font-semibold">
            {formatCurrency(stats.total)}
          </div>
        </div>
        <div className="bg-white/5 rounded-md p-3">
          <div className="text-white/60 text-xs">Média</div>
          <div className="text-white font-semibold">
            {formatCurrency(stats.avg)}
          </div>
        </div>
        <div className="bg-white/5 rounded-md p-3 flex items-center gap-2">
          <div className="flex-1">
            <div className="text-white/60 text-xs">Tendência</div>
            <div
              className={`font-semibold flex items-center gap-1 ${
                stats.trend > 0
                  ? "text-[#5BB376]"
                  : stats.trend < 0
                  ? "text-[#B35B5B]"
                  : "text-white/80"
              }`}
            >
              {stats.trend > 0 ? (
                <TrendingUp size={12} />
              ) : stats.trend < 0 ? (
                <TrendingDown size={12} />
              ) : null}
              {Math.abs(stats.trend).toFixed(1)}%
            </div>
          </div>
        </div>
      </div>

      {/* Área do gráfico */}
      <div className="relative h-64 flex items-end justify-between">
        {/* Eixo Y com valores */}
        <div className="absolute left-0 top-0 h-full flex flex-col justify-between text-xs text-white/40 w-10">
          <span className="text-right">{formatValue(stats.max)}</span>
          <span className="text-right">{formatValue(stats.max * 0.75)}</span>
          <span className="text-right">{formatValue(stats.max * 0.5)}</span>
          <span className="text-right">{formatValue(stats.max * 0.25)}</span>
          <span className="text-right">0</span>
        </div>

        {/* Barras do gráfico */}
        <div className="flex-1 ml-12 h-full flex items-end justify-between gap-1">
          {chartData.map((item, index) => (
            <div
              key={index}
              className="flex flex-col items-center gap-3 flex-1 group cursor-pointer"
            >
              {/* Barra */}
              <div
                className="w-full max-w-12 flex flex-col justify-end relative"
                style={{ height: "200px" }}
              >
                <div
                  className="w-full bg-gradient-to-t from-[#df5454] to-[#5BB3F5] rounded-t-md transition-all duration-700 ease-out shadow-lg relative overflow-hidden hover:shadow-xl"
                  style={{
                    height: `${getBarHeight(item.value)}%`,
                    minHeight: item.value > 0 ? "3px" : "0px",
                    boxShadow:
                      item.value > 0
                        ? "0 -4px 12px rgba(60, 142, 220, 0.3)"
                        : "none",
                  }}
                >
                  {/* Efeito de brilho na barra */}
                  {item.value > 0 && (
                    <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent opacity-50" />
                  )}

                  {/* Tooltip detalhado */}
                  <div className="absolute -top-16 left-1/2 transform -translate-x-1/2 opacity-0 group-hover:opacity-100 transition-all duration-200 bg-black/95 text-white text-xs px-3 py-2 rounded-md whitespace-nowrap z-10 shadow-xl border border-white/10">
                    <div className="font-medium">{item.period}</div>
                    <div className="text-[#df5454]">
                      {formatCurrency(item.value)}
                    </div>
                    {item.date && (
                      <div className="text-white/60 text-xs">
                        {new Date(item.date).toLocaleDateString("pt-BR")}
                      </div>
                    )}
                    <div className="absolute top-full left-1/2 transform -translate-x-1/2 w-0 h-0 border-l-2 border-r-2 border-t-4 border-l-transparent border-r-transparent border-t-black/95"></div>
                  </div>
                </div>
              </div>
              {/* Label do período */}
              <span className="text-xs text-white/60 font-medium">
                {item.period}
              </span>
            </div>
          ))}
        </div>
      </div>

      {/* Estatísticas detalhadas */}
      <div className="flex items-center justify-between mt-4 pt-4 border-t border-white/[0.06]">
        <div className="text-white/60 text-sm">
          Período:{" "}
          <span className="text-white/80">{periodLabels[selectedPeriod]}</span>
        </div>
        <div className="flex items-center gap-4">
          <div className="text-white/60 text-sm">
            Máximo:{" "}
            <span className="text-[#df5454] font-medium">
              {formatCurrency(stats.max)}
            </span>
          </div>
          <div className="text-white/60 text-sm">
            Mínimo:{" "}
            <span className="text-white/80 font-medium">
              {formatCurrency(stats.min)}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AdvancedBalanceChart;
