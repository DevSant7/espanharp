import { useState, useEffect } from "react";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { fetchNui } from "@app/utils/fetchNui";

export interface ServerVehicle {
  id?: number;
  name: string;
  spawn: string;
  image: string;
  favorite: boolean;
  attributes: {
    engine: number;
    body: number;
    gas: number;
    trunk: number;
  };
}

export interface PersonalVehicle extends ServerVehicle {
  plate: string;
}

export const useServerVehicles = () => {
  const [vehicles, setVehicles] = useState<ServerVehicle[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalVehicles, setTotalVehicles] = useState(0);
  const [hasMore, setHasMore] = useState(false);
  const [currentSearch, setCurrentSearch] = useState("");
  const [currentCategory, setCurrentCategory] = useState("all");

  const VEHICLES_PER_PAGE = 1200; // Aumentado para 1200 veículos por página

  // Buscar veículos do servidor com paginação
  const fetchVehicles = async (page: number = 1, searchTerm: string = "", category: string = "all", append: boolean = false) => {
    setLoading(true);
    setError(null);
    try {
      await fetchNui("getServerVehicles", {
        page,
        limit: VEHICLES_PER_PAGE,
        searchTerm,
        category
      });
      
      // Atualizar estado atual
      setCurrentPage(page);
      setCurrentSearch(searchTerm);
      setCurrentCategory(category);
    } catch (err) {
      setError("Erro ao buscar veículos");
      console.error("Erro ao buscar veículos:", err);
    } finally {
      setLoading(false);
    }
  };

  // Carregar mais veículos (próxima página)
  const loadMoreVehicles = async () => {
    if (hasMore && !loading) {
      await fetchVehicles(currentPage + 1, currentSearch, currentCategory, true);
    }
  };

  // Spawnar veículo
  const spawnVehicle = async (vehicle: ServerVehicle) => {
    try {
      await fetchNui("spawnVehicle", { vehicle });
    } catch (err) {
      console.error("Erro ao spawnar veículo:", err);
    }
  };

  // Adicionar veículo ao usuário
  const addVehicleToUser = async (vehicle: ServerVehicle, userId: number, duration?: number) => {
    try {
      await fetchNui("addVehicleToUser", { vehicle, userId, duration });
    } catch (err) {
      console.error("Erro ao adicionar veículo ao usuário:", err);
    }
  };

  // Remover veículo do usuário
  const removeVehicleFromUser = async (vehicle: PersonalVehicle, userId: number) => {
    try {
      await fetchNui("removeVehicleFromUser", { vehicle, userId });
    } catch (err) {
      console.error("Erro ao remover veículo do usuário:", err);
    }
  };

  // Favoritar veículo
  const favoriteVehicle = async (vehicle: ServerVehicle) => {
    try {
      const updatedVehicles = await fetchNui("favoriteVehicle", { vehicle });
      setVehicles(updatedVehicles);
    } catch (err) {
      console.error("Erro ao favoritar veículo:", err);
    }
  };

  // Desfavoritar veículo
  const unfavoriteVehicle = async (vehicle: ServerVehicle) => {
    try {
      const updatedVehicles = await fetchNui("unfavoriteVehicle", { vehicle });
      setVehicles(updatedVehicles);
    } catch (err) {
      console.error("Erro ao desfavoritar veículo:", err);
    }
  };

  // Filtrar veículos por nome
  const searchVehicles = (searchTerm: string): ServerVehicle[] => {
    if (!searchTerm.trim()) return vehicles;
    
    return vehicles.filter(vehicle =>
      vehicle.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      vehicle.spawn.toLowerCase().includes(searchTerm.toLowerCase())
    );
  };

  // Obter veículos favoritos
  const getFavoriteVehicles = (): ServerVehicle[] => {
    return vehicles.filter(vehicle => vehicle.favorite);
  };

  // Obter veículos por categoria (baseado no nome)
  const getVehiclesByCategory = (category: string): ServerVehicle[] => {
    if (category === "all") return vehicles;
    if (category === "favorites") return getFavoriteVehicles();
    
    return vehicles.filter(vehicle => {
      const name = vehicle.name.toLowerCase();
      return name.includes(category.toLowerCase());
    });
  };

  // Obter categorias disponíveis
  const getCategories = (): string[] => {
    const categories = new Set<string>();
    categories.add("all");
    categories.add("favorites");
    
    vehicles.forEach(vehicle => {
      const name = vehicle.name.toLowerCase();
      if (name.includes("carro") || name.includes("car")) {
        categories.add("carros");
      } else if (name.includes("moto") || name.includes("bike")) {
        categories.add("motos");
      } else if (name.includes("caminhão") || name.includes("truck")) {
        categories.add("caminhoes");
      }
    });
    
    return Array.from(categories);
  };

  // Event listeners para receber dados do servidor
  useNuiEvent("receiveServerVehicles", (data: { vehicles: ServerVehicle[], total: number, page: number, hasMore: boolean }) => {
    if (data.page === 1) {
      // Primeira página - substituir veículos
      setVehicles(data.vehicles);
    } else {
      // Páginas seguintes - adicionar aos existentes
      setVehicles(prev => [...prev, ...data.vehicles]);
    }
    
    setTotalVehicles(data.total);
    setHasMore(data.hasMore);
    setLoading(false);
  });

  useNuiEvent("receiveVehiclesError", (errorMessage: string) => {
    setError(errorMessage);
    setLoading(false);
  });

  return {
    vehicles,
    loading,
    error,
    fetchVehicles,
    loadMoreVehicles,
    spawnVehicle,
    addVehicleToUser,
    removeVehicleFromUser,
    favoriteVehicle,
    unfavoriteVehicle,
    searchVehicles,
    getFavoriteVehicles,
    getVehiclesByCategory,
    getCategories,
    totalVehicles,
    hasMore,
    currentPage
  };
};
