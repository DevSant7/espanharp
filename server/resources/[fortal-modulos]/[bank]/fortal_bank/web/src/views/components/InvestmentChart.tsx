import React from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  ResponsiveContainer,
  Tooltip,
} from "recharts";

const data = [
  { time: "11/05", value: 83 },
  { time: "12/05", value: 84 },
  { time: "13/05", value: 86 },
  { time: "14/05", value: 85 },
  { time: "15/05", value: 87 },
  { time: "16/05", value: 89 },
  { time: "17/05", value: 88 },
  { time: "18/05", value: 90 },
  { time: "19/05", value: 92 },
  { time: "20/05", value: 94 },
  { time: "21/05", value: 93 },
  { time: "22/05", value: 95 },
  { time: "23/05", value: 97 },
  { time: "24/05", value: 96 },
  { time: "25/05", value: 98 },
];

interface InvestmentChartProps {
  className?: string;
}

const formatCurrency = (value: number) => {
  return new Intl.NumberFormat("pt-BR", {
    style: "currency",
    currency: "BRL",
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(value * 1000);
};

export default function InvestmentChart({ className }: InvestmentChartProps) {
  const CustomTooltip = ({ active, payload, label }: any) => {
    if (active && payload && payload.length) {
      return (
        <div className="bg-black/80 border border-white/10 rounded-md p-3">
          <p className="text-white/60 text-xs">{label}</p>
          <p className="text-[#5BB376] text-sm font-semibold">
            {formatCurrency(payload[0].value)}
          </p>
        </div>
      );
    }
    return null;
  };

  return (
    <div
      className={`flex flex-col rounded-md p-6 h-[17.5rem] ${className}`}
      style={{
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
      }}
    >
      <div className="flex items-center mb-4">
        <div className="flex items-center gap-2">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="12"
            height="12"
            viewBox="0 0 12 12"
            fill="none"
          >
            <path
              d="M1 11L11 1M11 1H4M11 1V8"
              stroke="#5BB376"
              strokeWidth="1.5"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
          </svg>
          <span className="text-white/40 text-sm font-medium">Crescimento</span>
          <span className="text-[#5BB376] text-sm font-medium">+0,32</span>
        </div>
      </div>

      <div className="flex-1 w-full">
        <ResponsiveContainer width="100%" height="100%">
          <LineChart
            data={data}
            margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
          >
            <XAxis
              dataKey="time"
              axisLine={false}
              tickLine={false}
              tick={{ fontSize: 11, fill: "#FFFFFF40" }}
            />
            <YAxis
              axisLine={false}
              tickLine={false}
              tick={{ fontSize: 11, fill: "#FFFFFF40" }}
              tickFormatter={(value: number) =>
                `0.${value < 90 ? "0" : ""}${value}`
              }
              domain={[80, 100]}
            />
            <Tooltip content={<CustomTooltip />} />
            <Line
              type="monotone"
              dataKey="value"
              stroke="#5BB376"
              strokeWidth={2}
              dot={false}
              activeDot={{ r: 4, fill: "#5BB376" }}
            />
          </LineChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
}
