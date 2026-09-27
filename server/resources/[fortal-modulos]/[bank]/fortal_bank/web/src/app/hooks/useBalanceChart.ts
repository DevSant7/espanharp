import { useState, useEffect, useCallback } from "react";

interface ChartData {
  period: string;
  value: number;
  date?: string;
}

type PeriodFilter = "daily" | "weekly" | "monthly";

interface UseBalanceChartProps {
  initialPeriod?: PeriodFilter;
  fetchData?: (
    period: PeriodFilter,
    startDate: string,
    endDate: string
  ) => Promise<ChartData[]>;
}

interface UseBalanceChartReturn {
  data: ChartData[];
  loading: boolean;
  error: string | null;
  period: PeriodFilter;
  setPeriod: (period: PeriodFilter) => void;
  refresh: () => void;
  dateRange: { start: string; end: string };
  setDateRange: (range: { start: string; end: string }) => void;
}

// Simulação de API - substitua por sua chamada real
const mockApiCall = async (
  period: PeriodFilter,
  startDate: string,
  endDate: string
): Promise<ChartData[]> => {
  // Simular delay da rede
  await new Promise((resolve) =>
    setTimeout(resolve, Math.random() * 1000 + 500)
  );

  // Simular possível erro (5% de chance)
  if (Math.random() < 0.05) {
    throw new Error("Erro ao buscar dados do servidor");
  }

  const now = new Date();

  switch (period) {
    case "daily":
      return Array.from({ length: 7 }, (_, i) => {
        const date = new Date(now);
        date.setDate(date.getDate() - (6 - i));
        const dayNames = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
        // Simular dados mais realistas com variação
        const baseValue = 100000 + Math.random() * 400000;
        const weekendMultiplier =
          date.getDay() === 0 || date.getDay() === 6 ? 0.3 : 1;
        return {
          period: dayNames[date.getDay()],
          value: Math.round(baseValue * weekendMultiplier),
          date: date.toISOString().split("T")[0],
        };
      });

    case "weekly":
      return Array.from({ length: 8 }, (_, i) => {
        const weekStart = new Date(now);
        weekStart.setDate(weekStart.getDate() - 7 * (7 - i));
        return {
          period: `Sem ${i + 1}`,
          value: Math.round(200000 + Math.random() * 300000),
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
        // Simular sazonalidade (dezembro maior, fevereiro menor)
        const seasonality = i === 11 ? 1.5 : i === 1 ? 0.7 : 1;
        return {
          period: monthNames[i],
          value: Math.round((250000 + Math.random() * 350000) * seasonality),
          date: month.toISOString().split("T")[0],
        };
      });

    default:
      return [];
  }
};

export const useBalanceChart = ({
  initialPeriod = "weekly",
  fetchData,
}: UseBalanceChartProps = {}): UseBalanceChartReturn => {
  const [data, setData] = useState<ChartData[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [period, setPeriod] = useState<PeriodFilter>(initialPeriod);
  const [dateRange, setDateRange] = useState({
    start: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000)
      .toISOString()
      .split("T")[0],
    end: new Date().toISOString().split("T")[0],
  });

  const loadData = useCallback(async () => {
    setLoading(true);
    setError(null);

    try {
      const fetchFunction = fetchData || mockApiCall;
      const result = await fetchFunction(
        period,
        dateRange.start,
        dateRange.end
      );
      setData(result);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Erro desconhecido");
      console.error("Erro ao carregar dados do gráfico:", err);
    } finally {
      setLoading(false);
    }
  }, [period, dateRange, fetchData]);

  const refresh = useCallback(() => {
    loadData();
  }, [loadData]);

  // Carregar dados quando dependências mudarem
  useEffect(() => {
    loadData();
  }, [loadData]);

  // Atualizar range de datas quando período mudar
  useEffect(() => {
    const now = new Date();
    let start: Date;

    switch (period) {
      case "daily":
        start = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
        break;
      case "weekly":
        start = new Date(now.getTime() - 8 * 7 * 24 * 60 * 60 * 1000);
        break;
      case "monthly":
        start = new Date(now.getFullYear(), 0, 1); // Início do ano
        break;
      default:
        start = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
    }

    setDateRange({
      start: start.toISOString().split("T")[0],
      end: now.toISOString().split("T")[0],
    });
  }, [period]);

  return {
    data,
    loading,
    error,
    period,
    setPeriod,
    refresh,
    dateRange,
    setDateRange,
  };
};

// Exemplo de como integrar com sua API real
export const createRealApiCall = (baseUrl: string, authToken?: string) => {
  return async (
    period: PeriodFilter,
    startDate: string,
    endDate: string
  ): Promise<ChartData[]> => {
    const params = new URLSearchParams({
      period,
      start_date: startDate,
      end_date: endDate,
    });

    const response = await fetch(`${baseUrl}/api/balance-chart?${params}`, {
      headers: {
        "Content-Type": "application/json",
        ...(authToken && { Authorization: `Bearer ${authToken}` }),
      },
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();

    // Transformar resposta da API para o formato esperado
    return result.data.map((item: any) => ({
      period: item.label || item.period,
      value: parseFloat(item.amount || item.value),
      date: item.date,
    }));
  };
};
