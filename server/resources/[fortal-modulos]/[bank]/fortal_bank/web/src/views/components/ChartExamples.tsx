/**
 * EXEMPLO DE USO COMPLETO DO GRÁFICO DE BALANÇO
 *
 * Este arquivo demonstra como implementar e usar os componentes de gráfico
 * criados, incluindo integração com dados reais e customizações.
 */

import React from "react";
import CustomBalanceChart from "./CustomBalanceChart";
import AdvancedBalanceChart from "./AdvancedBalanceChart";
import {
  useBalanceChart,
  createRealApiCall,
} from "../../app/hooks/useBalanceChart";

// Exemplo 1: Uso básico do componente customizado
export const BasicChartExample: React.FC = () => {
  return (
    <div className="space-y-6">
      <h2 className="text-white text-lg font-semibold">Exemplo Básico</h2>
      <CustomBalanceChart className="w-full max-w-2xl" />
    </div>
  );
};

// Exemplo 2: Uso avançado com dados reais
export const AdvancedChartExample: React.FC = () => {
  // Se você tiver uma API real, use assim:
  // const apiCall = createRealApiCall('https://sua-api.com', 'seu-token');
  // const { data, loading, error, period, setPeriod, refresh } = useBalanceChart({
  //   fetchData: apiCall
  // });

  // Para este exemplo, vamos usar dados simulados
  const {
    data,
    loading,
    error,
    period,
    setPeriod,
    refresh,
    dateRange,
    setDateRange,
  } = useBalanceChart({
    initialPeriod: "weekly",
  });

  const handlePeriodChange = (newPeriod: "daily" | "weekly" | "monthly") => {
    setPeriod(newPeriod);
  };

  const handleDataRequest = async (
    period: "daily" | "weekly" | "monthly",
    startDate: string,
    endDate: string
  ) => {
    // Aqui você faria a chamada para sua API
    // return await fetch('/api/balance-data', { ... });

    // Por enquanto, retornamos os dados do hook
    return data;
  };

  if (error) {
    return (
      <div className="bg-red-900/20 border border-red-500/30 rounded-md p-4">
        <h3 className="text-red-400 font-medium">Erro ao carregar dados</h3>
        <p className="text-red-300 text-sm">{error}</p>
        <button
          onClick={refresh}
          className="mt-2 px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 transition-colors"
        >
          Tentar novamente
        </button>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-white text-lg font-semibold">
          Exemplo Avançado com API
        </h2>
        <button
          onClick={refresh}
          disabled={loading}
          className="px-4 py-2 bg-[#df5454] text-white rounded hover:bg-[#2E6BB8] disabled:opacity-50 transition-colors"
        >
          {loading ? "Carregando..." : "Atualizar"}
        </button>
      </div>

      <AdvancedBalanceChart
        className="w-full"
        onPeriodChange={handlePeriodChange}
        onDataRequest={handleDataRequest}
      />
    </div>
  );
};

// Exemplo 3: Integração com FiveM (exemplo para servidor de RP)
export const FiveMIntegrationExample: React.FC = () => {
  const fetchFiveMData = async (
    period: "daily" | "weekly" | "monthly",
    startDate: string,
    endDate: string
  ) => {
    // Exemplo de integração com NUI do FiveM
    if (typeof window !== "undefined" && (window as any).invokeNative) {
      try {
        const result = await fetch("https://admin/getBalanceData", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ period, startDate, endDate }),
        });

        return await result.json();
      } catch (error) {
        console.error("Erro na comunicação com FiveM:", error);
        throw error;
      }
    }

    // Fallback para dados simulados se não estiver no FiveM
    return [];
  };

  return (
    <div className="space-y-6">
      <h2 className="text-white text-lg font-semibold">Integração FiveM</h2>
      <AdvancedBalanceChart className="w-full" onDataRequest={fetchFiveMData} />
    </div>
  );
};

// Exemplo 4: Múltiplos gráficos em dashboard
export const DashboardExample: React.FC = () => {
  return (
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
      {/* Gráfico de Receitas */}
      <div className="space-y-2">
        <h3 className="text-white/80 text-sm font-medium">Receitas</h3>
        <CustomBalanceChart className="w-full" />
      </div>

      {/* Gráfico de Despesas */}
      <div className="space-y-2">
        <h3 className="text-white/80 text-sm font-medium">Despesas</h3>
        <CustomBalanceChart className="w-full" />
      </div>

      {/* Gráfico Avançado - Ocupando 2 colunas */}
      <div className="lg:col-span-2 space-y-2">
        <h3 className="text-white/80 text-sm font-medium">Análise Detalhada</h3>
        <AdvancedBalanceChart className="w-full" />
      </div>
    </div>
  );
};

// Exemplo de customização com temas
export const ThemedChartExample: React.FC = () => {
  const themes = {
    blue: {
      primary: "#df5454",
      secondary: "#5BB3F5",
      background:
        "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(60, 142, 220, 0.02) 0%, rgba(60, 142, 220, 0.00) 100%)",
    },
    green: {
      primary: "#5BB376",
      secondary: "#7BC393",
      background:
        "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(91, 179, 118, 0.02) 0%, rgba(91, 179, 118, 0.00) 100%)",
    },
    purple: {
      primary: "#8B5CF6",
      secondary: "#A78BFA",
      background:
        "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(139, 92, 246, 0.02) 0%, rgba(139, 92, 246, 0.00) 100%)",
    },
  };

  const [selectedTheme, setSelectedTheme] =
    React.useState<keyof typeof themes>("blue");

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-white text-lg font-semibold">Exemplo com Temas</h2>
        <div className="flex gap-2">
          {Object.keys(themes).map((theme) => (
            <button
              key={theme}
              onClick={() => setSelectedTheme(theme as keyof typeof themes)}
              className={`px-3 py-1 rounded text-sm transition-colors ${
                selectedTheme === theme
                  ? "bg-white/20 text-white"
                  : "bg-white/5 text-white/60 hover:text-white/80"
              }`}
            >
              {theme.charAt(0).toUpperCase() + theme.slice(1)}
            </button>
          ))}
        </div>
      </div>

      <div
        className="rounded-md p-6"
        style={{ background: themes[selectedTheme].background }}
      >
        {/* Aqui você customizaria as cores do gráfico baseado no tema */}
        <CustomBalanceChart className="w-full" />
      </div>
    </div>
  );
};

/**
 * INSTRUÇÕES DE IMPLEMENTAÇÃO
 *
 * 1. Componente Básico (CustomBalanceChart):
 *    - Use para gráficos simples sem necessidade de dados externos
 *    - Personalize os dados simulados conforme necessário
 *    - Ideal para prototipagem rápida
 *
 * 2. Componente Avançado (AdvancedBalanceChart):
 *    - Use quando precisar integrar com APIs reais
 *    - Suporte a filtros de data personalizados
 *    - Estatísticas automáticas (média, máximo, tendência)
 *    - Loading states e tratamento de erros
 *
 * 3. Hook personalizado (useBalanceChart):
 *    - Gerencia estado dos dados, loading e erros
 *    - Fácil integração com APIs
 *    - Atualização automática quando parâmetros mudam
 *
 * 4. Integração com FiveM:
 *    - Use fetch para comunicar com o cliente/servidor
 *    - Implemente callbacks NUI adequados
 *    - Trate erros de conexão graciosamente
 *
 * 5. Customização de estilos:
 *    - Modifique as cores CSS/Tailwind
 *    - Ajuste o gradiente de fundo
 *    - Personalize tooltips e animações
 *
 * EXEMPLO DE USO NA SUA PÁGINA:
 *
 * import { AdvancedBalanceChart } from '@/components/charts';
 * import { useBalanceChart, createRealApiCall } from '@/hooks/useBalanceChart';
 *
 * const MyPage = () => {
 *   const apiCall = createRealApiCall('https://minha-api.com', authToken);
 *
 *   return (
 *     <AdvancedBalanceChart
 *       className="w-full"
 *       onDataRequest={apiCall}
 *     />
 *   );
 * };
 */
