import { useEffect, useState } from "react";

import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import { usePlayerSearch } from "@/stores/useSearch";
import { usePermissions } from "@/providers/Permissions";

export const Search = () => {
  const [search, setSearch] = useState("");
  const [selected, setSelected] = useState(-1);
  const [selectedButton, setSelectedButton] = useState("Histórico");
  const { current: players, set: setPlayers } = usePlayerSearch();
  const { canPerformAction } = usePermissions();

  useEffect(() => {
    Post.create("getPlayers").then((resp: any) => {
      setPlayers(resp);
    });
  }, []);

  // Listener para atualização em tempo real
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === 'updatePlayerHistory') {
      
        if (selected >= 0 && players[selected]?.passport) {
          fetchPlayerData(players[selected].passport);
        }
      }
    };
    
    window.addEventListener('message', handleMessage);
    
    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, [selected, players]);

  // Função para buscar dados específicos de um jogador
  const fetchPlayerData = async (playerId: string) => {
    try {
      const playerData = await Post.create("getPlayerData", { playerId });
      if (playerData && typeof playerData === 'object' && 'history' in playerData) {
        // Atualizar o jogador selecionado com os dados completos
        const updatedPlayers = players.map(player => 
          player.passport === playerId ? { ...player, ...playerData } : player
        );
        setPlayers(updatedPlayers as any);
      }
    } catch (error) {
      console.error("Erro ao buscar dados do jogador:", error);
    }
  };

  // Função para excluir histórico
  const handleRemoveHistory = async (historyData: any) => {
   
    
    try {
      const dataToSend = {
        time: historyData.time,
        id: historyData.id,
        playerId: players[selected]?.passport
      };
      
     
      
      await Post.create("removeHistory", dataToSend);
      

      
      // Atualizar dados do jogador após exclusão
      if (players[selected]?.passport) {
      
        fetchPlayerData(players[selected].passport);
      }
    } catch (error) {
      console.error("Erro ao excluir histórico:", error);
    }
  };

  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.search className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          {selected >= 0 ? "Perfil" : "Buscar"}
        </h1>
      </Title>
      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        <h1 className="text-[.8vw] text-[#FFFFFF4D]">
          Esses dados são confidenciais. Não compartilhe com terceiros.
        </h1>
        {selected < 0 ? (
          <>
            <div className="mt-[.8vw] flex h-[2.5vw] w-full items-center gap-[.8vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
              <Icon.search className="text-white/60 drop-shadow-[0_0_15px_#FFFFFF]" />
              <input
                placeholder="Buscar (Nome, ID)"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="h-full w-[52vw] bg-transparent text-[.8vw] text-white placeholder:text-[#FFFFFF80]"
                type="text"
              />
            </div>
            <div className="mt-[1vw] h-[25vw] w-full">
              {search && (
                <div className="h-[2vw]">
                  <h1 className="text-[.8vw] text-[#FFFFFF73]">
                    Resultados encontrados para
                    <span className="capitalize text-[#FFFFFFB2]">
                      {" "}
                      '{search}'
                    </span>
                  </h1>
                </div>
              )}
              <div className="announce-scroll grid h-[calc(100%-2vw)] w-full grid-cols-3 gap-[.5vw] overflow-auto pr-[.5vw]">
                {search && (
                  <>
                    {players
                      .filter((data) => {
                        const lowerSearch = search.toLowerCase();
                        return (
                          data.name.toLowerCase().includes(lowerSearch) ||
                          String(data.passport).includes(lowerSearch)
                        );
                      })
                      .map((data) => {
                        // Encontrar o índice real no array original
                        const originalIndex = players.findIndex(player => player.passport === data.passport);
                        
                        return (
                        <div
                          onClick={() => {
                           
                            setSelected(originalIndex);
                            // Buscar dados específicos do jogador
                            fetchPlayerData(data.passport);
                          }}
                          key={data.passport}
                          className="flex h-[6vw] w-full items-center gap-[1vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section p-[.5vw]"
                        >
                          <div className="flex h-full w-[5vw] items-center justify-center rounded-[.2vw]">
                            <img
                              src={
                                data.photo
                                  ? data.photo
                                  : "./default-profile.png"
                              }
                              className="h-full w-full"
                              alt=""
                            />
                          </div>
                          <div>
                            <p className="text-[.7vw] text-[#FFFFFF80]">Nome</p>
                            <h1 className="text-[.8vw] text-white">
                              {data.name}
                            </h1>
                            <p className="text-[.7vw] text-[#FFFFFF80]">
                              Passaporte
                            </p>
                            <h1 className="text-[.8vw] text-white">
                              {data.passport}
                            </h1>
                          </div>
                        </div>
                      );
                    })}
                  </>
                )}
              </div>
            </div>
          </>
        ) : (
          <div>
            <button
              onClick={() => {
                setSelected(-1);
                setSearch("");
              }}
              className="close mt-[.5vw] flex h-[2.3vw] w-full items-center rounded-[.3vw] text-[.8vw] text-white"
            >
              <Icon.close />
              Voltar
            </button>
            <div className="mt-[.5vw] w-full rounded-[.3vw] border border-[#FFFFFF08] bg-section">
              <div className="flex h-[2vw] w-full items-center bg-[#FFFFFF05] px-[1vw]">
                <h1 className="text-[.8vw] text-[#FFFFFFA6]">
                  Informações de{" "}
                  <span className="text-white">
                    '{players[selected]?.name}'
                  </span>
                </h1>
              </div>
              {(() => {
                
                return null;
              })()}

              <div className="flex h-[10vw] w-full items-center p-[.5vw]">
                <div className="flex h-full w-[10vw] items-center justify-center rounded-[.3vw]">
                  <img
                    src={
                      players[selected]?.photo
                        ? players[selected]?.photo
                        : "./default-profile.png"
                    }
                    className="h-full w-full"
                    alt=""
                  />
                </div>
                <div className="ml-[.5vw] grid h-full w-[calc(100%-10vw)] grid-cols-2 gap-[.3vw]">
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">NOME</h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.name}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">
                        PASSAPORTE
                      </h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.passport}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">REGISTRO</h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.register}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">IDADE</h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.years}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">
                        PROCURADO
                      </h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.wanted}
                    </p>
                  </div>
                  <div className="flex h-full w-full items-center justify-between gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] bg-section px-[.5vw]">
                    <div className="flex items-center gap-[.5vw]">
                      <Icon.list2 />
                      <h1 className="text-[.8vw] text-[#FFFFFF73]">
                        PORTE DE ARMAS
                      </h1>
                    </div>
                    <p className="text-[.8vw] capitalize text-white">
                      {players[selected]?.size}
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <div className="mt-[.5vw] h-[13vw] w-full">
              <div className="flex w-full items-center justify-between gap-[.5vw]">
                <button
                  onClick={() => setSelectedButton("Histórico")}
                  className={`h-[2.5vw] w-full rounded-[.2vw] border border-[#FFFFFF08] ${selectedButton === "Histórico" ? "close text-white" : "bg-[#FFFFFF05] text-[#FFFFFF80]"} text-[.8vw] uppercase`}
                >
                  Histórico
                </button>
              </div>
              <div className="mt-[.5vw] h-[calc(100%-3vw)] w-full overflow-auto rounded-[.3vw] border border-[#FFFFFF0D] bg-[#FFFFFF08]">
                <div className="flex h-[2vw] w-full flex-none items-center justify-between border-b border-solid border-[#FFFFFF14] px-[.5vw]">
                  <h1 className="w-[4vw] text-[.8vw] text-[#FFFFFFA6]">Tipo</h1>
                  <h1 className="w-[4vw] text-[.8vw] text-[#FFFFFFA6]">Data</h1>
                  <h1 className="w-[9vw] text-[.8vw] text-[#FFFFFFA6]">
                    Agente
                  </h1>
                  <h1 className="w-[6vw] text-[.8vw] text-[#FFFFFFA6]">
                    Descrição
                  </h1>
                  <h1 className="w-[7vw] text-center text-[.8vw] text-[#FFFFFFA6]">
                    Tempo/Valor
                  </h1>
                  <h1 className="w-[3vw] text-center text-[.8vw] text-[#FFFFFFA6]">Ações</h1>
                </div>
                {players[selected]?.history?.map((data: any, index: number) => (
                  <div key={index} className="flex h-[2.4vw] w-full items-center justify-between border-b border-solid border-[#FFFFFF14] px-[.5vw]">
                    <h1 className="w-[4vw] text-[.8vw] text-[#FFFFFFA6]">
                      {data.type}
                    </h1>
                    <h1 className="w-[4vw] text-[.8vw] text-[#FFFFFFA6]">
                      {data.date}
                    </h1>
                    <h1 className="w-[9vw] text-[.8vw] text-[#FFFFFFA6]">
                      <span className="mr-[.3vw] rounded-[.3vw] border border-[#FFFFFF12] bg-[#FFFFFF0D] px-[.3vw] py-[.1vw] text-[.7vw] text-white">
                        #{data.id}
                      </span>
                      <span className="text-[.8vw] text-white">
                        {data.name}
                      </span>
                    </h1>
                    <h1 className="w-[6vw] text-[.8vw] text-[#FFFFFFA6]">
                      {data.description}
                    </h1>
                    <h1 className="w-[7vw] text-center text-[.8vw] text-[#FFFFFFA6]">
                      {data.time}
                    </h1>
                    <div className="w-[3vw] text-center">
                      {canPerformAction('canEditHistory') && (
                        <button
                          onClick={() => handleRemoveHistory(data)}
                          className="text-[.8vw] text-[#DE5757C9] hover:text-[#DE575790] transition-colors"
                        >
                          Excluir
                        </button>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};
