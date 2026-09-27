import {
  Bar,
  BarChart,
  CartesianGrid,
  Tooltip,
  XAxis,
  YAxis,
  ResponsiveContainer,
} from "recharts";

import { selectedStatisticsProps } from "@/types";

export function Chart({
  selectedStatistics,
}: {
  selectedStatistics: selectedStatisticsProps;
}) {
  const defaultStatistic = [
    {
      name: "Itens apreendidas",
      Valor: 0,
    },
    {
      name: "Veículos apreendidos",
      Valor: 0,
    },
    {
      name: "B.O's registrados",
      Valor: 0,
    },
    {
      name: "Prisões realizadas",
      Valor: 0,
    },
    {
      name: "Multas aplicadas",
      Valor: 0,
    },
  ];

  // Verificar se selectedStatistics e data existem e são arrays
  const chartData = selectedStatistics && 
                   selectedStatistics.data && 
                   Array.isArray(selectedStatistics.data) 
                   ? selectedStatistics.data 
                   : defaultStatistic;

  return (
    <ResponsiveContainer width="100%" height="100%">
      <BarChart
        data={chartData}
        innerRadius={10}
      >
        <CartesianGrid
          vertical={false}
          color="red"
          strokeWidth={0.13}
          strokeOpacity={0.3}
        />
        <YAxis tickLine={false} axisLine={false} fontSize={14} />
        <XAxis
          dataKey="name"
          strokeWidth={0.13}
          strokeOpacity={0.3}
          axisLine={false}
          tickLine={false}
          fontSize={13}
          fontWeight={400}
        />
        <Tooltip
          separator=": "
          cursor={false}
          labelStyle={{
            color: "#23272A",
            fontWeight: 500,
          }}
          itemStyle={{
            color: "#23272A",
            fontWeight: 700,
          }}
          contentStyle={{
            borderRadius: "5px",
            background: "#FFF",
            border: 0,
            outline: 0,
          }}
        />
        <Bar
          dataKey="Valor"
          className="fill-primary"
          radius={[8, 8, 0, 0]}
          maxBarSize={39}
        />
      </BarChart>
    </ResponsiveContainer>
  );
}
