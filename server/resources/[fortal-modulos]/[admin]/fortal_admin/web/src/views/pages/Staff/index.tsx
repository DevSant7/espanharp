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
import { Search, Users, AlertCircle, ArrowUp, ArrowDown, X } from "lucide-react";
import { useServerStaff, StaffMember } from "@app/hooks/useServerStaff";
import { useStaffRefresh } from "@app/hooks/useAutoRefresh";

export function Staff() {
  const {
    staffMembers,
    loading,
    error,
    fetchStaff,
    promoteStaff,
    demoteStaff,
    removeStaff,
    searchStaff,
    getNextRank,
    getPreviousRank
  } = useServerStaff();

  const [searchTerm, setSearchTerm] = useState("");
  const [selectedMember, setSelectedMember] = useState<StaffMember | null>(null);

  // Auto-refresh quando a página fica visível
  useStaffRefresh();

  // Buscar staff quando a página carrega
  useEffect(() => {
    fetchStaff();
  }, []);

  // Filtrar staff baseado no termo de busca
  const filteredStaff = searchTerm.trim() ? searchStaff(searchTerm) : staffMembers;

  // Função para obter cor do grupo
  const getGroupColor = (group: string) => {
    const groupColors: Record<string, { color: string; bgColor: string }> = {
      "Owner": { color: "#FFD700", bgColor: "#FFD70020" },
      "Admin": { color: "#FF4444", bgColor: "#FF444420" },
      "Moderador": { color: "#df5454", bgColor: "#df545420" },
      "Suporte": { color: "#10B981", bgColor: "#10B98120" }
    };
    return groupColors[group] || { color: "#FFFFFF", bgColor: "#FFFFFF20" };
  };

  // Função para promover membro
  const handlePromote = async (member: StaffMember) => {
    const nextRank = getNextRank(member.group);
    if (nextRank) {
      await promoteStaff(member.id, member.group, nextRank);
      setSelectedMember(null);
    }
  };

  // Função para rebaixar membro
  const handleDemote = async (member: StaffMember) => {
    const previousRank = getPreviousRank(member.group);
    if (previousRank) {
      await demoteStaff(member.id, member.group, previousRank);
      setSelectedMember(null);
    }
  };

  // Função para demitir membro
  const handleRemove = async (member: StaffMember) => {
    if (confirm(`Tem certeza que deseja demitir ${member.name} do staff?`)) {
      await removeStaff(member.id, member.group);
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
        Administração
      </h1>
      <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF03] mt-[1.2rem]" />

      {/* Barra de busca */}
      <div className="relative w-[70rem] ml-[1.06rem] mt-4">
        <input
          type="text"
          placeholder="Buscar membros do staff..."
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
            <span>Carregando staff...</span>
          </div>
        </div>
      )}

      {/* Error State */}
      {error && (
        <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
          <div className="flex items-center gap-3 text-red-400">
            <AlertCircle className="w-6 h-6" />
            <span>Erro ao carregar staff: {error}</span>
          </div>
        </div>
      )}

      {/* Empty State */}
      {!loading && !error && filteredStaff.length === 0 && (
        <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
          <div className="flex flex-col items-center gap-3 text-white/60">
            <Users className="w-12 h-12" />
            <span>Nenhum membro do staff encontrado</span>
            {searchTerm.trim() && (
              <span className="text-sm">Tente outro termo de busca</span>
            )}
          </div>
        </div>
      )}

      {/* Staff Table */}
      {!loading && !error && filteredStaff.length > 0 && (
      <div className="overflow-y-auto h-[43.6875rem] scrollbar-hide">
        <Table className="leading-[2.75rem] bg-[#FFFFFF03] w-[69.9375rem] m-4 border border-white/[.03] rounded-[0.375rem]">
            <TableHeader className="bg-[#FFFFFF05] text-white/60 text-[0.9375rem] font-bold">
              <TableRow>
                <TableHead>STAFF</TableHead>
                <TableHead>PASSAPORTE</TableHead>
                <TableHead>CARGO</TableHead>
                <TableHead>STATUS</TableHead>
                <TableHead className="text-center">AÇÕES</TableHead>
              </TableRow>
            </TableHeader>
          <TableBody>
              {filteredStaff.map((member: StaffMember) => {
                const groupColor = getGroupColor(member.group);
                
                return (
                  <TableRow 
                    key={member.id}
                    className="hover:bg-white/[.02]"
                  >
                <TableCell className="text-white text-sm font-bold max-w-[12.5rem] truncate">
                      <div className="flex items-center gap-2">
                        <span>{member.name}</span>
                      </div>
                </TableCell>

                <TableCell>
                  <div className="inline-flex items-start justify-start p-[0.625rem] rounded border border-white/[.03] bg-white/[.03] text-white/80 text-sm font-bold">
                        {member.id}
                  </div>
                </TableCell>

                <TableCell className="text-white">
                  <div className="inline-flex items-start justify-start p-[0.625rem] rounded border border-white/[.03] bg-white/[.03] text-white/80 text-sm font-bold">
                        {member.group}
                  </div>
                </TableCell>

                <TableCell className="text-white">
                      <div
                        className="inline-flex p-[0.6875rem] h-[2.0625rem] items-center justify-center gap-2 rounded border border-white/[.05] text-sm"
                        style={{
                          background: member.online ? "#9CF35B0D" : "#FF4B4B0D",
                          color: member.online ? "#9CF35B" : "#FF4B4B",
                          fontWeight: 500,
                        }}
                      >
                        <span
                          className="w-2 h-2 rounded-full"
                          style={{
                            background: member.online ? "#9CF35B" : "#FF4B4B",
                          }}
                        />
                        {member.online ? "Online" : "Offline"}
                      </div>
                </TableCell>

                    <TableCell className="text-center h-[2.75rem] align-middle">
                      <div className="flex items-center justify-center gap-[.31rem] h-full">
                        {/* Botão Promover */}
                        {getNextRank(member.group) && (
                          <div 
                            className="flex items-center justify-center size-[1.875rem] bg-[rgba(140,212,86,0.06)] border border-[rgba(140,212,86,0.12)] rounded-[0.25rem] cursor-pointer hover:opacity-80 transition"
                            onClick={() => handlePromote(member)}
                            title={`Promover para ${getNextRank(member.group)}`}
                          >
                            <ArrowUp className="w-4 h-4 text-green-400" />
                          </div>
                        )}

                        {/* Botão Rebaixar */}
                        {getPreviousRank(member.group) && (
                          <div 
                            className="flex items-center justify-center size-[1.875rem] bg-[#FFB9510F] border border-[#FFB95126] rounded-[0.25rem] cursor-pointer hover:opacity-80 transition"
                            onClick={() => handleDemote(member)}
                            title={`Rebaixar para ${getPreviousRank(member.group)}`}
                          >
                            <ArrowDown className="w-4 h-4 text-orange-400" />
                  </div>
                        )}

                        {/* Botão Demitir */}
                        <div 
                          className="flex items-center justify-center size-[1.875rem] bg-[#E35A5A0F] border border-[#E35A5A1F] rounded-[0.25rem] cursor-pointer hover:opacity-80 transition"
                          onClick={() => handleRemove(member)}
                          title="Demitir do staff"
                        >
                          <X className="w-4 h-4 text-red-400" />
                  </div>
                  </div>
                </TableCell>
              </TableRow>
                );
              })}
          </TableBody>
        </Table>
      </div>
      )}

      {/* Modal de Detalhes do Membro */}
      {selectedMember && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-[#1a1a1a] border border-white/[.1] rounded-lg p-6 w-[40rem] max-h-[30rem] overflow-y-auto">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-white text-xl font-bold flex items-center gap-2">
                {selectedMember.name}
              </h2>
              <button
                onClick={() => setSelectedMember(null)}
                className="text-white/50 hover:text-white text-2xl"
              >
                <X className="w-6 h-6" />
              </button>
            </div>
            
            <div className="space-y-4">
              <div className="flex items-center justify-between p-3 bg-white/[.03] rounded-md border border-white/[.05]">
                <span className="text-white/70">ID:</span>
                <span className="text-white font-medium">{selectedMember.id}</span>
              </div>
              
              <div className="flex items-center justify-between p-3 bg-white/[.03] rounded-md border border-white/[.05]">
                <span className="text-white/70">Cargo:</span>
                <div
                  className="px-3 py-1 rounded text-sm font-medium"
                  style={{
                    background: getGroupColor(selectedMember.group).bgColor,
                    color: getGroupColor(selectedMember.group).color,
                  }}
                >
                  {selectedMember.group}
                </div>
              </div>
              
              <div className="flex items-center justify-between p-3 bg-white/[.03] rounded-md border border-white/[.05]">
                <span className="text-white/70">Status:</span>
                <div
                  className="flex items-center gap-2 px-3 py-1 rounded text-sm font-medium"
                  style={{
                    background: selectedMember.online ? "#9CF35B0D" : "#FF4B4B0D",
                    color: selectedMember.online ? "#9CF35B" : "#FF4B4B",
                  }}
                >
                  <span
                    className="w-2 h-2 rounded-full"
                    style={{
                      background: selectedMember.online ? "#9CF35B" : "#FF4B4B",
                    }}
                  />
                  {selectedMember.online ? "Online" : "Offline"}
                </div>
              </div>

              <div className="flex gap-2 mt-4">
                {getNextRank(selectedMember.group) && (
                  <button
                    onClick={() => handlePromote(selectedMember)}
                    className="flex items-center gap-2 px-4 py-2 bg-green-500/20 border border-green-500/30 rounded-md text-green-400 hover:bg-green-500/30 transition"
                  >
                    <ArrowUp className="w-4 h-4" />
                    Promover para {getNextRank(selectedMember.group)}
                  </button>
                )}
                
                {getPreviousRank(selectedMember.group) && (
                  <button
                    onClick={() => handleDemote(selectedMember)}
                    className="flex items-center gap-2 px-4 py-2 bg-orange-500/20 border border-orange-500/30 rounded-md text-orange-400 hover:bg-orange-500/30 transition"
                  >
                    <ArrowDown className="w-4 h-4" />
                    Rebaixar para {getPreviousRank(selectedMember.group)}
                  </button>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </motion.div>
  );
}