import * as motion from "motion/react-client";
import { Separator } from "@views/components/ui/separator";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@views/components/ui/table";
import { useState, useEffect } from "react";
import { Search, Building2, Users, AlertCircle } from "lucide-react";
import { useServerOrganizations } from "@app/hooks/useServerOrganizations";
import { useOrganizationsRefresh } from "@app/hooks/useAutoRefresh";

export function Organizations() {
  const {
    organizations,
    loading,
    error,
    fetchOrganizations,
    searchOrganizations
  } = useServerOrganizations();

  const [searchTerm, setSearchTerm] = useState("");

  // Auto-refresh quando a página fica visível
  useOrganizationsRefresh();

  // Buscar organizações quando a página carrega
  useEffect(() => {
    console.log("🏢 [ORGANIZATIONS] Página carregada, buscando organizações...");
    fetchOrganizations();
  }, []);


  // Filtrar organizações baseado no termo de busca
  const filteredOrganizations = searchTerm.trim() ? searchOrganizations(searchTerm) : organizations;


  // Função para determinar o tipo da organização baseado no nome
  const getOrganizationType = (name: string) => {
    const lowerName = name.toLowerCase();
    
    if (lowerName.includes("hospital") || lowerName.includes("medic") || lowerName.includes("saude")) {
      return { name: "Saúde", bg: "#FF4B4B0D", color: "#FF4B4B" };
    } else if (lowerName.includes("police") || lowerName.includes("policia") || lowerName.includes("pm")) {
      return { name: "Policial", bg: "#df54540D", color: "#df5454" };
    } else if (lowerName.includes("military") || lowerName.includes("militar") || lowerName.includes("exercito")) {
      return { name: "Militar", bg: "#8B5CF60D", color: "#8B5CF6" };
    } else if (lowerName.includes("gang") || lowerName.includes("facção") || lowerName.includes("crime")) {
      return { name: "Criminal", bg: "#FFB9510D", color: "#FFB951" };
    } else if (lowerName.includes("government") || lowerName.includes("governo") || lowerName.includes("prefeitura")) {
      return { name: "Governo", bg: "#10B9810D", color: "#10B981" };
    } else {
      return { name: "Organização", bg: "#FFFFFF05", color: "#FFFFFF" };
    }
  };

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
        Organizações
      </h1>
      <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF08] mt-[1.2rem]" />


      <div className="relative w-[70rem] ml-[1.06rem] mt-4">
        <input
          type="text"
          placeholder="Buscar organizações..."
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


      {/* Loading State */}
      {loading && (
        <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
          <div className="flex items-center gap-3 text-white/60">
            <div className="w-6 h-6 border-2 border-white/30 border-t-white rounded-full animate-spin" />
            <span>Carregando organizações...</span>
          </div>
        </div>
      )}

      {/* Error State */}
      {error && (
        <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
          <div className="flex items-center gap-3 text-red-400">
            <AlertCircle className="w-6 h-6" />
            <span>Erro ao carregar organizações: {error}</span>
          </div>
        </div>
      )}

      {/* Empty State */}
      {!loading && !error && filteredOrganizations.length === 0 && (
        <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
          <div className="flex flex-col items-center gap-3 text-white/60">
            <Building2 className="w-12 h-12" />
            <span>Nenhuma organização encontrada</span>
            {searchTerm.trim() && (
              <span className="text-sm">Tente outro termo de busca</span>
            )}
          </div>
        </div>
      )}

      {/* Organizations Table */}
      {!loading && !error && filteredOrganizations.length > 0 && (
        <div className="overflow-y-auto h-[40rem] scrollbar-hide">
          <Table className="leading-[2.75rem] bg-[#FFFFFF03] w-[69.9375rem] m-4 border border-white/[.03] rounded-[0.375rem]">
            <TableHeader className="bg-[#FFFFFF05] text-white/60 text-[0.9375rem] font-bold">
              <TableRow>
                <TableHead>NOME</TableHead>
                <TableHead>TIPO</TableHead>
                <TableHead>LÍDER</TableHead>
                <TableHead>MEMBROS</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {filteredOrganizations.map((organization) => {
                const typeInfo = getOrganizationType(organization.name);
                
                return (
                  <TableRow 
                    key={organization.id}
                    className="hover:bg-white/[.02]"
                  >
                    <TableCell className="text-white text-base font-medium max-w-[12.5rem] truncate">
                      <div className="flex items-center gap-2">
                        <Building2 className="w-4 h-4 text-white/50" />
                        {organization.name}
                      </div>
                    </TableCell>

                    <TableCell>
                      <div
                        className="inline-flex p-[0.6875rem] h-[2.0625rem] items-center justify-center rounded border border-white/[.05] text-sm"
                        style={{
                          background: typeInfo.bg,
                          color: typeInfo.color,
                          fontWeight: 500,
                        }}
                      >
                        {typeInfo.name}
                      </div>
                    </TableCell>

                    <TableCell className="text-white text-base font-medium">
                      {organization.leader ? (
                        <span className="text-white">
                          {organization.leader.name}
                        </span>
                      ) : (
                        <span className="text-white/30">Sem líder</span>
                      )}
                    </TableCell>

                    <TableCell className="text-white text-base font-medium">
                      <div className="flex items-center gap-2">
                        <Users className="w-4 h-4 text-white/50" />
                        <span>{organization.totalMembers}</span>
                      </div>
                    </TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </div>
      )}

    </motion.div>
  );
}