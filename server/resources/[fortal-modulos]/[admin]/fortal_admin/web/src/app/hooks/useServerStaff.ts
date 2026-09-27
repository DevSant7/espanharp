import { useState, useEffect } from "react";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { fetchNui } from "@app/utils/fetchNui";

export interface StaffMember {
  id: number;
  name: string;
  group: string;
  level: number;
  online: boolean;
  source?: number;
  color: string;
  bgColor: string;
  canPromote: boolean;
  canDemote: boolean;
  canManage: boolean;
}

export const useServerStaff = () => {
  const [staffMembers, setStaffMembers] = useState<StaffMember[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Hook para receber staff do servidor
  useNuiEvent("receiveServerStaff", (data: StaffMember[]) => {
    console.log("👥 [STAFF] Staff recebido do servidor:", data.length);
    setStaffMembers(data);
    setLoading(false);
    setError(null);
  });

  // Hook para receber erro
  useNuiEvent("receiveStaffError", (errorMessage: string) => {
    console.error("❌ [STAFF] Erro ao buscar staff:", errorMessage);
    setError(errorMessage);
    setLoading(false);
  });

  // Função para buscar staff do servidor
  const fetchStaff = async () => {
    console.log("🔍 [STAFF] Buscando staff do servidor...");
    setLoading(true);
    setError(null);
    await fetchNui("getServerStaff");
  };

  // Função para promover membro do staff
  const promoteStaff = async (targetUserId: number, currentGroup: string, newGroup: string) => {
    console.log("⬆️ [STAFF] Promovendo staff:", targetUserId, "de", currentGroup, "para", newGroup);
    try {
      await fetchNui("promoteStaff", {
        targetUserId,
        currentGroup,
        newGroup
      });
      // Recarregar staff após promoção
      await fetchStaff();
    } catch (err) {
      console.error("❌ [STAFF] Erro ao promover staff:", err);
    }
  };

  // Função para rebaixar membro do staff
  const demoteStaff = async (targetUserId: number, currentGroup: string, newGroup: string) => {
    console.log("⬇️ [STAFF] Rebaixando staff:", targetUserId, "de", currentGroup, "para", newGroup);
    try {
      await fetchNui("demoteStaff", {
        targetUserId,
        currentGroup,
        newGroup
      });
      // Recarregar staff após rebaixamento
      await fetchStaff();
    } catch (err) {
      console.error("❌ [STAFF] Erro ao rebaixar staff:", err);
    }
  };

  // Função para demitir membro do staff
  const removeStaff = async (targetUserId: number, currentGroup: string) => {
    console.log("🗑️ [STAFF] Demitindo staff:", targetUserId, "do grupo", currentGroup);
    try {
      await fetchNui("removeStaff", {
        targetUserId,
        currentGroup
      });
      // Recarregar staff após demissão
      await fetchStaff();
    } catch (err) {
      console.error("❌ [STAFF] Erro ao demitir staff:", err);
    }
  };

  // Função para filtrar staff por grupo
  const getStaffByGroup = (group: string) => {
    return staffMembers.filter(member => member.group === group);
  };

  // Função para buscar staff por nome
  const searchStaff = (searchTerm: string) => {
    if (!searchTerm.trim()) return staffMembers;
    const lowerTerm = searchTerm.toLowerCase();
    return staffMembers.filter(member => 
      member.name.toLowerCase().includes(lowerTerm) ||
      member.group.toLowerCase().includes(lowerTerm)
    );
  };

  // Função para obter estatísticas do staff
  const getStaffStats = () => {
    const stats = {
      total: staffMembers.length,
      online: staffMembers.filter(m => m.online).length,
      offline: staffMembers.filter(m => !m.online).length,
      byGroup: {} as Record<string, number>
    };

    // Contar por grupo
    staffMembers.forEach(member => {
      if (!stats.byGroup[member.group]) {
        stats.byGroup[member.group] = 0;
      }
      stats.byGroup[member.group]++;
    });

    return stats;
  };

  // Função para obter próximo cargo na hierarquia
  const getNextRank = (currentGroup: string) => {
    const hierarchy = ["Suporte", "Moderador", "Admin", "Owner"];
    const currentIndex = hierarchy.indexOf(currentGroup);
    if (currentIndex >= 0 && currentIndex < hierarchy.length - 1) {
      return hierarchy[currentIndex + 1];
    }
    return null;
  };

  // Função para obter cargo anterior na hierarquia
  const getPreviousRank = (currentGroup: string) => {
    const hierarchy = ["Suporte", "Moderador", "Admin", "Owner"];
    const currentIndex = hierarchy.indexOf(currentGroup);
    if (currentIndex > 0) {
      return hierarchy[currentIndex - 1];
    }
    return null;
  };

  // Função para verificar se pode promover/rebaixar
  const canManageStaff = (member: StaffMember, currentUserLevel: number) => {
    return currentUserLevel > member.level;
  };

  return {
    staffMembers,
    loading,
    error,
    fetchStaff,
    promoteStaff,
    demoteStaff,
    removeStaff,
    getStaffByGroup,
    searchStaff,
    getStaffStats,
    getNextRank,
    getPreviousRank,
    canManageStaff
  };
};
