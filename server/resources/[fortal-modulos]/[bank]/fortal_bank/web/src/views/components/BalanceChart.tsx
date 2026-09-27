import React, { useState, useMemo } from "react";
import { BarChart, Bar, XAxis, YAxis, ResponsiveContainer } from "recharts";

interface ChartData {
  day: string;
  value: number;
}

interface BalanceChartProps {
  data?: ChartData[];
  className?: string;
}

type PeriodFilter = "daily" | "weekly" | "monthly";

const BalanceChart: React.FC<BalanceChartProps> = ({ className }) => {
  const [selectedPeriod, setSelectedPeriod] = useState<PeriodFilter>("weekly");

  const generateData = (period: PeriodFilter): ChartData[] => {
    switch (period) {
      case "daily":
        return [
          { day: "Seg", value: 520000 },
          { day: "Ter", value: 180000 },
          { day: "Qua", value: 160000 },
          { day: "Qui", value: 50000 },
          { day: "Sex", value: 0 },
          { day: "Sáb", value: 0 },
          { day: "Dom", value: 600000 },
        ];
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
          { day: "Jan", value: 450000 },
          { day: "Fev", value: 320000 },
          { day: "Mar", value: 580000 },
          { day: "Abr", value: 200000 },
          { day: "Mai", value: 100000 },
          { day: "Jun", value: 350000 },
          { day: "Jul", value: 480000 },
        ];
      default:
        return [];
    }
  };

  const chartData = useMemo(
    () => generateData(selectedPeriod),
    [selectedPeriod]
  );

  const maxValue = useMemo(() => {
    return Math.max(...chartData.map((item) => item.value));
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
    daily: "Diário",
    weekly: "Semanal",
    monthly: "Mensal",
  };

  return (
    <div
      className={`flex flex-col rounded-md p-6 ${className}`}
      style={{
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
      }}
    >
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-2">
          <svg
            width="12"
            height="12"
            viewBox="0 0 24 24"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <rect
              width="24"
              height="24"
              rx="3"
              fill="#df5454"
              fillOpacity="0.08"
            />
            <path
              d="M3 13C3 13.2652 3.10536 13.5196 3.29289 13.7071C3.48043 13.8946 3.73478 14 4 14H9C9.26522 14 9.51957 13.8946 9.70711 13.7071C9.89464 13.5196 10 13.2652 10 13V4C10 3.73478 9.89464 3.48043 9.70711 3.29289C9.51957 3.10536 9.26522 3 9 3H4C3.73478 3 3.48043 3.10536 3.29289 3.29289C3.10536 3.48043 3 3.73478 3 4V13ZM14 21C14 21.2652 14.1054 21.5196 14.2929 21.7071C14.4804 21.8946 14.7348 22 15 22H20C20.2652 22 20.5196 21.8946 20.7071 21.7071C20.8946 21.5196 21 21.2652 21 21V10C21 9.73478 20.8946 9.48043 20.7071 9.29289C20.5196 9.10536 20.2652 9 20 9H15C14.7348 9 14.4804 9.10536 14.2929 9.29289C14.1054 9.48043 14 9.73478 14 10V21Z"
              fill="#df5454"
            />
          </svg>
          <h3 className="text-white/40 text-sm font-normal">Balanço</h3>
        </div>

        <div className="flex items-center gap-2 p-1 rounded-md bg-white/[0.05]">
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

      <div className="h-64 w-full">
        <ResponsiveContainer width="100%" height="100%">
          <BarChart
            data={chartData}
            margin={{
              top: 20,
              right: 30,
              left: 20,
              bottom: 20,
            }}
            barCategoryGap="20%"
          >
            <XAxis
              dataKey="day"
              axisLine={false}
              tickLine={false}
              tick={{
                fontSize: 12,
                fill: "rgba(255, 255, 255, 0.6)",
              }}
              dy={10}
            />
            <YAxis
              axisLine={false}
              tickLine={false}
              tick={{
                fontSize: 12,
                fill: "rgba(255, 255, 255, 0.4)",
              }}
              tickFormatter={formatValue}
              domain={[0, maxValue * 1.1]}
            />
            <Bar dataKey="value" radius={[4, 4, 0, 0]} fill="#df5454" />
          </BarChart>
        </ResponsiveContainer>
      </div>

      <div className="flex items-center justify-between mt-4 pt-4 border-t border-white/[0.06]">
        <div className="text-white/60 text-sm">
          Período:{" "}
          <span className="text-white/80">{periodLabels[selectedPeriod]}</span>
        </div>
        <div className="text-white/60 text-sm">
          Máximo:{" "}
          <span className="text-[#df5454] font-medium">
            ${formatValue(maxValue)}
          </span>
        </div>
      </div>
    </div>
  );
};

export default BalanceChart;
