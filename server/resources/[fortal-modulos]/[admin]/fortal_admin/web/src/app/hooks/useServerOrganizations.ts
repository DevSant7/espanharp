import { useState, useEffect } from "react";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { fetchNui } from "@app/utils/fetchNui";

export interface OrganizationMember {
  id: number;
  name: string;
  level: number;
  online: boolean;
  source?: number;
  role: string;
}

export interface ServerOrganization {
  id: number;
  name: string;
  leader: OrganizationMember | null;
  members: OrganizationMember[];
  totalMembers: number;
  onlineMembers: number;
}

export const useServerOrganizations = () => {
  const [organizations, setOrganizations] = useState<ServerOrganization[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [selectedOrganization, setSelectedOrganization] = useState<ServerOrganization | null>(null);
  const [organizationMembers, setOrganizationMembers] = useState<OrganizationMember[]>([]);

  // Hook para receber organizações do servidor
  useNuiEvent("receiveServerOrganizations", (data: ServerOrganization[]) => {
    console.log("🏢 [ORGANIZATIONS] Organizações recebidas do servidor:", data?.length || 0, data);
    if (data && Array.isArray(data)) {
      setOrganizations(data);
      setLoading(false);
      setError(null);
    } else {
      console.error("❌ [ORGANIZATIONS] Dados inválidos recebidos:", data);
      setError("Dados inválidos recebidos do servidor");
      setLoading(false);
    }
  });

  // Hook para receber membros de uma organização
  useNuiEvent("receiveOrganizationMembers", (data: { groupName: string; members: OrganizationMember[] }) => {
    console.log("👥 [ORGANIZATIONS] Membros recebidos da organização:", data.groupName, data.members.length);
    setOrganizationMembers(data.members);
    setLoading(false);
    setError(null);
  });

  // Hook para receber erro
  useNuiEvent("receiveOrganizationsError", (errorMessage: string) => {
    console.error("❌ [ORGANIZATIONS] Erro ao buscar organizações:", errorMessage);
    setError(errorMessage);
    setLoading(false);
  });

  // Função para buscar organizações do servidor
  const fetchOrganizations = async () => {
    console.log("🔍 [ORGANIZATIONS] Buscando organizações do servidor...");
    setLoading(true);
    setError(null);
    try {
      await fetchNui("getServerOrganizations");
    } catch (error) {
      console.error("❌ [ORGANIZATIONS] Erro ao buscar organizações:", error);
      setError("Erro ao buscar organizações");
      setLoading(false);
    }
  };


  // Função para buscar membros de uma organização específica
  const fetchOrganizationMembers = async (groupName: string) => {
    console.log("👥 [ORGANIZATIONS] Buscando membros da organização:", groupName);
    setLoading(true);
    setError(null);
    await fetchNui("getOrganizationMembers", { groupName });
  };

  // Função para selecionar uma organização e buscar seus membros
  const selectOrganization = async (organization: ServerOrganization) => {
    setSelectedOrganization(organization);
    await fetchOrganizationMembers(organization.name);
  };

  // Função para filtrar organizações por nome
  const searchOrganizations = (searchTerm: string) => {
    if (!searchTerm.trim()) return organizations;
    const lowerTerm = searchTerm.toLowerCase();
    return organizations.filter(org => 
      org.name.toLowerCase().includes(lowerTerm) ||
      (org.leader && org.leader.name.toLowerCase().includes(lowerTerm))
    );
  };

  // Função para obter organizações com líder
  const getOrganizationsWithLeader = () => {
    return organizations.filter(org => org.leader !== null);
  };

  // Função para obter organizações sem líder
  const getOrganizationsWithoutLeader = () => {
    return organizations.filter(org => org.leader === null);
  };

  // Função para obter organizações por tamanho
  const getOrganizationsBySize = (minMembers: number, maxMembers?: number) => {
    return organizations.filter(org => {
      if (maxMembers) {
        return org.totalMembers >= minMembers && org.totalMembers <= maxMembers;
      }
      return org.totalMembers >= minMembers;
    });
  };

  // Função para obter estatísticas das organizações
  const getOrganizationStats = () => {
    const totalOrgs = organizations.length;
    const totalMembers = organizations.reduce((sum, org) => sum + org.totalMembers, 0);
    const orgsWithLeader = organizations.filter(org => org.leader !== null).length;
    const orgsWithoutLeader = totalOrgs - orgsWithLeader;
    const avgMembersPerOrg = totalOrgs > 0 ? Math.round(totalMembers / totalOrgs) : 0;

    return {
      totalOrganizations: totalOrgs,
      totalMembers,
      organizationsWithLeader: orgsWithLeader,
      organizationsWithoutLeader: orgsWithoutLeader,
      averageMembersPerOrganization: avgMembersPerOrg
    };
  };

  return {
    organizations,
    loading,
    error,
    selectedOrganization,
    organizationMembers,
    fetchOrganizations,
    fetchOrganizationMembers,
    selectOrganization,
    searchOrganizations,
    getOrganizationsWithLeader,
    getOrganizationsWithoutLeader,
    getOrganizationsBySize,
    getOrganizationStats
  };
};
