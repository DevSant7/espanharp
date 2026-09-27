import { useState, useEffect } from "react";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { fetchNui } from "@app/utils/fetchNui";
import { useAutoRefresh } from "@app/hooks/useAutoRefresh";

export interface ServerItem {
  id: number;
  name: string;
  spawn: string;
  image: string;
  weight?: number;
  category?: string;
  type?: string;
}

export const useServerItems = () => {
  const [items, setItems] = useState<ServerItem[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Hook para receber itens do servidor
  useNuiEvent("receiveServerItems", (data: ServerItem[]) => {
    console.log("📦 [ITEMS] Itens recebidos do servidor:", data.length);
    setItems(data);
    setLoading(false);
    setError(null);
  });

  // Hook para receber erro
  useNuiEvent("receiveItemsError", (errorMessage: string) => {
    console.error("❌ [ITEMS] Erro ao buscar itens:", errorMessage);
    setError(errorMessage);
    setLoading(false);
  });

  // Função para buscar itens do servidor
  const fetchItems = async () => {
    console.log("🔍 [ITEMS] Buscando itens do servidor...");
    setLoading(true);
    setError(null);
    await fetchNui("getServerItems");
  };

  // Hook para atualização automática quando o painel se tornar visível
  useAutoRefresh([fetchItems]);

  // Função para pegar item
  const takeItem = async (item: ServerItem, quantity: number) => {
    console.log("📦 [ITEMS] Pegando item:", item.name, "Quantidade:", quantity);
    console.log("📦 [ITEMS] Item spawn:", item.spawn);
    
    try {
      await fetchNui("takeItem", {
        item: item.spawn,
        quantity: quantity
      });
      console.log("✅ [ITEMS] Item solicitado com sucesso");
    } catch (error) {
      console.error("❌ [ITEMS] Erro ao solicitar item:", error);
    }
  };

  // Função para filtrar itens por categoria
  const getItemsByCategory = (category: string) => {
    return items.filter(item => item.category === category);
  };

  // Função para buscar itens por nome
  const searchItems = (searchTerm: string) => {
    if (!searchTerm.trim()) return items;
    return items.filter(item => 
      item.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.spawn.toLowerCase().includes(searchTerm.toLowerCase())
    );
  };

  // Função para obter categorias únicas
  const getCategories = () => {
    const categories = [...new Set(items.map(item => item.category).filter(Boolean))];
    return categories as string[];
  };

  return {
    items,
    loading,
    error,
    fetchItems,
    takeItem,
    getItemsByCategory,
    searchItems,
    getCategories
  };
};
