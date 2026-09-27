import * as motion from "motion/react-client";
import { Separator } from "@views/components/ui/separator";
import { useState, useEffect } from "react";
import { Search, Package, AlertCircle } from "lucide-react";
import { useServerVehicles, ServerVehicle } from "@app/hooks/useServerVehicles";
import { useVehiclesRefresh } from "@app/hooks/useAutoRefresh";

export function Vehicles() {
  const {
    vehicles,
    error,
    spawnVehicle,
    fetchVehicles,
    loadMoreVehicles,
    totalVehicles,
    hasMore,
    currentPage
  } = useServerVehicles();

  const [searchTerm, setSearchTerm] = useState("");
  const [activeTab, setActiveTab] = useState<string>("carros");

  // Auto-refresh quando a página fica visível
  useVehiclesRefresh();

  // Função para detectar quando o usuário chegou ao fim do scroll
  const handleScroll = (e: React.UIEvent<HTMLDivElement>) => {
    const target = e.currentTarget;
    const nearBottom = target.scrollTop + target.clientHeight >= target.scrollHeight - 100;
    
    if (nearBottom && hasMore) {
      loadMoreVehicles();
    }
  };

  // Buscar veículos quando a página carrega ou quando muda filtro
  useEffect(() => {
    fetchVehicles(1, searchTerm, activeTab);
  }, [searchTerm, activeTab]);

  // Categorias disponíveis
  const categories = ["carros", "motos", "caminhoes", "aeronaves"];

  return (
    <motion.div
      initial={{ opacity: 0, scale: 0 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{
        duration: 0.4,
        scale: { type: "spring", visualDuration: 0.4, bounce: 0.2 },
      }}
      className="w-[72rem] flex flex-col"
    >
      <h1 className="text-white text-xl font-bold mt-[1.31rem] ml-[1.56rem]">
        Veículos
      </h1>
      <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF08] mt-[1.2rem]" />

      <div className="relative w-[70rem] ml-[1.06rem] mt-4">
        <input
          type="text"
          placeholder="Buscar"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full h-[3.125rem] text-white/85 placeholder-white/50 border border-white/[.03] rounded-md px-4 pl-10 py-2 outline-none text-base"
          style={{
            background:
              "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
          }}
        />
        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-[#FFFFFF59] w-5 h-5" />
      </div>

      <div className="flex items-center justify-between mt-[.62rem] mx-4">
        {[
          { label: "Carros", value: "carros" },
          { label: "Motos", value: "motos" },
          { label: "Caminhões", value: "caminhoes" },
          { label: "Aeronaves", value: "aeronaves" },
        ].map((tab) => (
          <button
            key={tab.value}
            onClick={() => setActiveTab(tab.value)}
            className={`w-[17rem] h-[3.125rem] rounded-[0.375rem] border border-white/[.03] font-medium text-[1rem] transition-all
              ${
                activeTab === tab.value
                  ? "bg-[#df5454] text-white"
                  : "text-white/50"
              }`}
            style={
              activeTab === tab.value
                ? {}
                : {
                    background:
                      "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                  }
            }
          >
            {tab.label}
          </button>
        ))}
      </div>


      {/* Error State */}
      {error && (
        <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
          <div className="flex items-center gap-3 text-red-400">
            <AlertCircle className="w-6 h-6" />
            <span>Erro ao carregar veículos: {error}</span>
          </div>
        </div>
      )}

      {/* Empty State */}
      {!error && vehicles.length === 0 && (
        <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
          <div className="flex flex-col items-center gap-3 text-white/60">
            <Package className="w-12 h-12" />
            <span>Nenhum veículo encontrado</span>
            {searchTerm.trim() && (
              <span className="text-sm">Tente outro termo de busca</span>
            )}
          </div>
        </div>
      )}

      {/* Vehicles Grid */}
      {!error && vehicles.length > 0 && (
        <div 
          className="mt-[.63rem] ml-[1.06rem] mr-[1.06rem] max-h-[36rem] overflow-y-auto scrollbar-hide"
          onScroll={handleScroll}
        >
          <div className="flex flex-wrap gap-[.75rem] w-[81rem]">
            {vehicles.map((vehicle) => (
              <div
                key={vehicle.spawn}
                className="w-[11.125rem] h-[14.0625rem] rounded-md border border-white/[.03] flex flex-col items-center justify-center hover:border-[#df545440]"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                }}
              >
                <div className="w-[9.125rem] flex items-center justify-start">
                  <h1 className="text-white text-sm font-bold">
                    {vehicle.favorite ? "⭐" : ""} {vehicle.name}
                  </h1>
                </div>

                <img
                  src={vehicle.image}
                  alt={vehicle.name}
                  className="w-[8.4375rem] h-[4.6875rem] my-[.81rem] object-contain"
                  loading="lazy"
                  decoding="async"
                  onError={(e) => {
                    e.currentTarget.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+Cjx0ZXh0IHg9IjUwIiB5PSI1NSIgZm9udC1mYW1pbHk9IkFyaWFsLCBzYW5zLXNlcmlmIiBmb250LXNpemU9IjQwIiBmaWxsPSIjZmZmZmZmIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj4/PC90ZXh0Pgo8L3N2Zz4K';
                  }}
                />

                <div className="w-[9.125rem] flex items-center justify-start">
                  <h1 className="text-white text-sm font-bold truncate" title={vehicle.name}>
                    {vehicle.name}
                  </h1>
                </div>

                <button 
                  className="flex items-center justify-center w-[9.125rem] h-8 rounded border border-white/[.05] bg-white/[.01] hover:bg-[#df5454] text-white/35 text-sm font-bold hover:text-white cursor-pointer transition-all mt-1"
                  onClick={() => spawnVehicle(vehicle)}
                >
                  SPAWNAR
                </button>
              </div>
            ))}
          </div>
          
        </div>
      )}
    </motion.div>
  );
}
