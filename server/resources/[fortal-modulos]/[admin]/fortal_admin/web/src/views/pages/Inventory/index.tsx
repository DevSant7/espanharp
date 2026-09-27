import * as motion from "motion/react-client";
import { Separator } from "@views/components/ui/separator";
import { useState } from "react";
import { Search, Package, AlertCircle } from "lucide-react";
import { Modal } from "@views/components/modal";
import { useServerItems, ServerItem } from "@app/hooks/useServerItems";

// Interface para compatibilidade com dados antigos (será removida)
interface LegacyItem {
  id: number;
  name: string;
  type: string;
  weight: number;
  img: string;
  category: string;
}

export function Inventory() {
  const {
    items,
    loading,
    error,
    takeItem,
    getItemsByCategory,
    searchItems,
    getCategories
  } = useServerItems();

  const [searchItem, setSearchItem] = useState("");
  const [modalTakeItemOpen, setModalTakeItemOpen] = useState(false);
  const [selectedItem, setSelectedItem] = useState<ServerItem | null>(null);
  const [itemQuantity, setItemQuantity] = useState<string>("1");
  const [visibleCount, setVisibleCount] = useState<number>(60);

  // Categorias fixas baseadas no tipo do item
  const categories = ["all", "armamento", "usável", "comum"];
  const [activeTab, setActiveTab] = useState<string>("all");

  // Filtrar itens baseado no tipo ativo e termo de busca
  const filteredItems = (() => {
    let filtered = items;
    
    // Filtrar por tipo se não for "all"
    if (activeTab !== "all") {
      filtered = items.filter(item => {
        const itemType = item.type?.toLowerCase() || "";
        return itemType === activeTab.toLowerCase();
      });
    }
    
    // Filtrar por termo de busca
    if (searchItem.trim()) {
      filtered = searchItems(searchItem);
    }
    
    return filtered;
  })();

  const increaseVisibleOnScroll = (e: React.UIEvent<HTMLDivElement>) => {
    const target = e.currentTarget;
    const nearBottom = target.scrollTop + target.clientHeight >= target.scrollHeight - 200;
    if (nearBottom) {
      setVisibleCount((prev) => Math.min(prev + 60, filteredItems.length));
    }
  };

  return (
    <>
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
          Inventário
        </h1>
        <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF08] mt-[1.2rem]" />

        <div className="relative w-[70rem] ml-[1.06rem] mt-4">
          <input
            type="text"
            placeholder="Buscar"
            value={searchItem}
            onChange={(e) => setSearchItem(e.target.value)}
            className="w-full h-[3.125rem] text-white/85 placeholder-white/50 border border-white/[.03] rounded-md px-4 pl-10 py-2 outline-none text-base"
            style={{
              background:
                "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
            }}
          />
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-[#FFFFFF59] w-5 h-5" />
        </div>

            <div className="mt-[.62rem] mx-4 overflow-x-auto scrollbar-hide">
              <div className="flex items-center justify-start gap-[.63rem] w-max">
              {/* Tab "Todos" */}
              <button
                onClick={() => setActiveTab("all")}
                className={`w-[23rem] h-[3.125rem] rounded-[0.375rem] border border-white/[.03] font-medium text-[1rem] transition-all
                ${
                  activeTab === "all"
                    ? "bg-[#df5454] text-white"
                    : "text-white/50"
                }`}
                style={
                  activeTab === "all"
                    ? {}
                    : {
                        background:
                          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                      }
                }
              >
                Todos ({items.length})
              </button>

              {/* Tab "Armamento" */}
              <button
                onClick={() => setActiveTab("armamento")}
                className={`w-[23rem] h-[3.125rem] rounded-[0.375rem] border border-white/[.03] font-medium text-[1rem] transition-all
                ${
                  activeTab === "armamento"
                    ? "bg-[#df5454] text-white"
                    : "text-white/50"
                }`}
                style={
                  activeTab === "armamento"
                    ? {}
                    : {
                        background:
                          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                      }
                }
              >
                Armamento ({items.filter(item => item.type?.toLowerCase() === "armamento").length})
              </button>

              {/* Tab "Usável" */}
              <button
                onClick={() => setActiveTab("usável")}
                className={`w-[23rem] h-[3.125rem] rounded-[0.375rem] border border-white/[.03] font-medium text-[1rem] transition-all
                ${
                  activeTab === "usável"
                    ? "bg-[#df5454] text-white"
                    : "text-white/50"
                }`}
                style={
                  activeTab === "usável"
                    ? {}
                    : {
                        background:
                          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                      }
                }
              >
                Usável ({items.filter(item => item.type?.toLowerCase() === "usável").length})
              </button>

              {/* Tab "Comum" */}
              <button
                onClick={() => setActiveTab("comum")}
                className={`w-[23rem] h-[3.125rem] rounded-[0.375rem] border border-white/[.03] font-medium text-[1rem] transition-all
                ${
                  activeTab === "comum"
                    ? "bg-[#df5454] text-white"
                    : "text-white/50"
                }`}
                style={
                  activeTab === "comum"
                    ? {}
                    : {
                        background:
                          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                      }
                }
              >
                Comum ({items.filter(item => item.type?.toLowerCase() === "comum").length})
              </button>
              </div>
            </div>

        {/* Loading State */}
        {loading && (
          <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
            <div className="flex items-center gap-3 text-white/60">
              <div className="w-6 h-6 border-2 border-white/30 border-t-white rounded-full animate-spin" />
              <span>Carregando itens...</span>
            </div>
          </div>
        )}

        {/* Error State */}
        {error && (
          <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
            <div className="flex items-center gap-3 text-red-400">
              <AlertCircle className="w-6 h-6" />
              <span>Erro ao carregar itens: {error}</span>
            </div>
          </div>
        )}

        {/* Empty State */}
        {!loading && !error && filteredItems.length === 0 && (
          <div className="mt-[.63rem] ml-[1.06rem] flex items-center justify-center h-40">
            <div className="flex flex-col items-center gap-3 text-white/60">
              <Package className="w-12 h-12" />
              <span>Nenhum item encontrado</span>
              {searchItem.trim() && (
                <span className="text-sm">Tente outro termo de busca</span>
              )}
            </div>
          </div>
        )}

        {/* Items Grid */}
        {!loading && !error && filteredItems.length > 0 && (
          <div className="mt-[.63rem] ml-[1.06rem] mr-[1.06rem] max-h-[36rem] overflow-y-auto scrollbar-hide"
               onScroll={increaseVisibleOnScroll}>
            <div className="flex flex-wrap gap-[.75rem] w-[81rem]">
            {filteredItems.slice(0, visibleCount).map((item) => (
              <div
                key={item.id}
                className="w-[11.125rem] h-[14.0625rem] rounded-md border border-white/[.03] flex flex-col items-center justify-center hover:border-[#df545440]"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                }}
              >
                <div className="w-[9.125rem] flex items-center justify-between">
                  <h1 className="text-white text-sm font-bold">1x</h1>
                  <span className="text-white/50 text-sm font-medium">
                    {item.weight || 0}Kg
                  </span>
                </div>

                <img
                  src={item.image}
                  alt={item.name}
                  className="size-[6.25rem] my-[.81rem] object-contain"
                  loading="lazy"
                  decoding="async"
                  onError={(e) => {
                    e.currentTarget.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+Cjx0ZXh0IHg9IjUwIiB5PSI1NSIgZm9udC1mYW1pbHk9IkFyaWFsLCBzYW5zLXNlcmlmIiBmb250LXNpemU9IjQwIiBmaWxsPSIjZmZmZmZmIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj4/PC90ZXh0Pgo8L3N2Zz4K';
                  }}
                />

                <div className="w-[9.125rem] flex items-center justify-between">
                  <h1 className="text-white text-sm font-bold truncate" title={item.name}>
                    {item.name}
                  </h1>
                  <span className="text-white/50 text-sm font-medium">
                    {item.type || "Item"}
                  </span>
                </div>

                <button
                  className="flex items-center justify-center w-[9.125rem] h-8 rounded border border-white/[.05] bg-white/[.01] hover:bg-[#df5454] text-white/35 text-sm font-bold hover:text-white cursor-pointer transition-all mt-1"
                  onClick={() => {
                    setSelectedItem(item);
                    setModalTakeItemOpen(true);
                  }}
                >
                  PEGAR
                </button>
              </div>
              ))}
            </div>
          </div>
        )}
      </motion.div>

      <Modal
        open={modalTakeItemOpen}
        onClose={() => setModalTakeItemOpen(false)}
      >
        <div className="w-full p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="w-6 h-6 flex items-center justify-center">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="#df5454">
                <path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z" />
              </svg>
            </div>
            <h2 className="text-white text-lg font-bold">
              Pegar item "{selectedItem?.name}"
            </h2>
          </div>

          <div className="mb-8">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Quantidade de itens
            </label>
            <input
              type="text"
              value={itemQuantity}
              onChange={(e) => setItemQuantity(e.target.value)}
              placeholder="X1"
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => setModalTakeItemOpen(false)}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors"
            >
              CANCELAR
            </button>
            <button
              onClick={async () => {
                if (selectedItem && itemQuantity) {
                  const quantity = parseInt(itemQuantity);
                  if (quantity > 0) {
                    await takeItem(selectedItem, quantity);
                    setModalTakeItemOpen(false);
                    setItemQuantity("1");
                  }
                }
              }}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors"
            >
              PEGAR
            </button>
          </div>
        </div>
      </Modal>
    </>
  );
}
