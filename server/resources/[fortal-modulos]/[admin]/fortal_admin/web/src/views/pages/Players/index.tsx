import * as motion from "motion/react-client";
import { useState, useEffect } from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation, Pagination } from "swiper/modules";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import {
  Table,
  TableHeader,
  TableBody,
  TableRow,
  TableHead,
  TableCell,
} from "@views/components/ui/table";
import { Separator } from "@views/components/ui/separator";
import React from "react";
import { ArrowLeft, Search } from "lucide-react";
import { fetchNui } from "@app/utils/fetchNui";
import { Modal } from "@views/components/modal";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { usePlayersRefresh } from "@app/hooks/useAutoRefresh";

interface Player {
  id: number;
  name: string;
  profession: string;
  passport: string;
  vip: string;
  status: "Online" | "Offline";
  professionColor: string;
  vipColor: string;
  online: boolean;
}


const vehicles = [
  {
    id: 1,
    name: "Civic Type-R",
    plate: "804-0BX",
    color: "Preto",
    year: "2022",
    image:
      "https://media.discordapp.net/attachments/894688869365194823/1420110275851456532/445_1.png?ex=68d43442&is=68d2e2c2&hm=825d055bcb044e89efd71e222b325c2b75d92b87bf8dfaab061eb5ba836fd6bc&=&format=webp&quality=lossless",
  },
  {
    id: 2,
    name: "BMW M3",
    plate: "123-ABC",
    color: "Azul",
    year: "2023",
    image:
      "https://media.discordapp.net/attachments/894688869365194823/1420110275851456532/445_1.png?ex=68d43442&is=68d2e2c2&hm=825d055bcb044e89efd71e222b325c2b75d92b87bf8dfaab061eb5ba836fd6bc&=&format=webp&quality=lossless",
  },
];

const items = [
  {
    id: 1,
    name: "AK-47",
    type: "Usável",
    weight: 5.0,
    img: "https://i.imgur.com/8YqG1bP.png",
    category: "weapon",
  },
  {
    id: 5,
    name: "AK-46",
    type: "Usável",
    weight: 5.0,
    img: "https://i.imgur.com/8YqG1bP.png",
    category: "weapon",
  },
  {
    id: 2,
    name: "Hambúrguer",
    type: "Usável",
    weight: 1.0,
    img: "https://i.imgur.com/8YqG1bP.png",
    category: "food",
  },
  {
    id: 3,
    name: "Alumínio",
    type: "Usável",
    weight: 0.5,
    img: "https://i.imgur.com/8YqG1bP.png",
    category: "material",
  },
];

const properties = [
  {
    id: 1,
    type: "Casa",
    name: "123 Ocean Drive, Miami, FL",
  },
  {
    id: 2,
    type: "Apartamento",
    name: "456 Park Avenue, New York, NY",
  },
  {
    id: 3,
    type: "Chácara",
    name: "789 Country Road, Springfield, IL",
  },
  {
    id: 4,
    type: "Cobertura",
    name: "101 Avenida Paulista, São Paulo, SP",
  },
  {
    id: 5,
    type: "Casa",
    name: "202 Mountain View, Boulder, CO",
  },
];

export function Players() {
  const [expandedRow, setExpandedRow] = useState<number | null>(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedPlayer, setSelectedPlayer] = useState<number | null>(null);
  const [modalSetVehicleOpen, setModalSetVehicleOpen] = useState(false);
  const [modalSendItemOpen, setModalSendItemOpen] = useState(false);
  const [selectedDays, setSelectedDays] = useState<number>(15);
  const [itemQuantity, setItemQuantity] = useState<number>(1);
  const [vehiclePlayerId, setVehiclePlayerId] = useState<string>("");
  const [vehicleSpawn, setVehicleSpawn] = useState<string>("");
  const [players, setPlayers] = useState<Player[]>([]);
  const [playerDetails, setPlayerDetails] = useState<any>(null);

  // Hook para receber eventos do NUI
  useNuiEvent("receivePlayers", (data: Player[]) => {
    setPlayers(data);
  });

  // Hook para receber dados detalhados do jogador
  useNuiEvent("receivePlayerDetails", (data: any) => {
    console.log("📥 [PLAYER-DETAILS] Dados recebidos:", JSON.stringify(data, null, 2));
    setPlayerDetails(data);
  });


  // Função para buscar jogadores
  const searchPlayers = async (term: string) => {
    await fetchNui("getPlayers", term);
  };

  // Função para buscar dados detalhados do jogador
  const getPlayerDetails = async (playerId: number) => {
    console.log("🔍 [PLAYER-DETAILS] Buscando dados do jogador:", playerId);
    await fetchNui("getPlayerDetails", playerId);
  };

  // Hook para atualizar dados automaticamente quando o painel se tornar visível
  usePlayersRefresh();

  // Buscar jogadores quando o termo de busca mudar
  useEffect(() => {
    const timeoutId = setTimeout(() => {
      // Se o campo estiver vazio, buscar primeiros 10 IDs
      // Se tiver conteúdo, buscar pelo termo
      searchPlayers(searchTerm.trim());
    }, 500); // Debounce de 500ms

    return () => clearTimeout(timeoutId);
  }, [searchTerm]);

  const actions = [
    {
      name: "VER DETALHES",
      onClick: (playerId: number) => {
        console.log("🖱️ [PLAYER-DETAILS] Botão clicado! ID:", playerId);
        getPlayerDetails(playerId);
      },
    },
    {
      name: "ESPECTAR",
      onClick: (playerId: number) => {
        fetchNui("spectatePlayer", { playerId });
      },
    },
    {
      name: "TELEPORTAR",
      onClick: (playerId: number) => {
        fetchNui("teleportPlayer", { playerId });
      },
    },
    {
      name: "PUXAR",
      onClick: (playerId: number) => {
        fetchNui("pullPlayer", { playerId });
      },
    },
    {
      name: "GOD",
      onClick: (playerId: number) => {
        fetchNui("godPlayer", { playerId });
      },
    },
    {
      name: "COLETE",
      onClick: (playerId: number) => {
        fetchNui("armorPlayer", { playerId });
      },
    },
    {
      name: "MATAR",
      onClick: (playerId: number) => {
        fetchNui("killPlayer", { playerId });
      },
    },
    {
      name: "ENVIAR ITEM",
      onClick: (playerId: number) => {
        setModalSendItemOpen(true);
      },
    },
    {
      name: "VER INVENTÁRIO",
      onClick: (playerId: number) => {
        fetchNui("viewPlayerInventory", { playerId });
      },
    },
    {
      name: "DINHEIRO",
      onClick: (playerId: number) => {
        fetchNui("giveMoneyToPlayer", { playerId });
      },
    },
    {
      name: "SETAR VEÍCULO",
      onClick: (playerId: number) => {
        setVehiclePlayerId(playerId.toString());
        setModalSetVehicleOpen(true);
      },
    },
    {
      name: "FIX",
      onClick: (playerId: number) => {
        fetchNui("fixPlayerVehicle", { playerId });
      },
    },
    {
      name: "TUNNING",
      onClick: (playerId: number) => {
        fetchNui("tunePlayerVehicle", { playerId });
      },
    },
    {
      name: "REMOVER WL",
      onClick: (playerId: number) => {
        fetchNui("removePlayerWhitelist", { playerId });
      },
    },
    {
      name: "EXPULSAR",
      onClick: (playerId: number) => {
        fetchNui("kickPlayer", { playerId });
      },
    },
    {
      name: "BANIR",
      onClick: (playerId: number) => {
        fetchNui("banPlayer", { playerId });
      },
    },
    {
      name: "VER INFORMAÇÕES",
      onClick: (playerId: number) => {
        setSelectedPlayer(playerId);
        getPlayerDetails(playerId);
      },
    },
  ];

  function getStatusColor(type: string) {
    switch (type) {
      case "Offline":
        return {
          bg: "#FF4B4B0D",
          color: "#FF4B4B",
        };
      case "Online":
        return {
          bg: "#9CF35B0D",
          color: "#9CF35B",
        };
      default:
        return {
          name: type,
          bg: "#FFFFFF05",
          color: "#FFFFFF",
        };
    }
  }

  function getProfessionColor(color?: string) {
    if (!color) {
      return {
        bg: "#FFFFFF03",
        color: "#C7C7C7",
      };
    }
    return {
      bg: `${color}0D`,
      color: color,
    };
  }

  function getVipColor(color?: string) {
    if (!color) {
      return {
        bg: "#FFFFFF03",
        color: "#C7C7C7",
      };
    }
    return {
      bg: `${color}0D`,
      color: color,
    };
  }

  const handleBack = () => {
    setSelectedPlayer(null);
    setPlayerDetails(null);
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
          Jogadores
        </h1>
        <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF08] mt-[1.2rem]" />

        {selectedPlayer ? (
          <div className="w-[70rem] ml-[1.06rem] mt-4">
            <button
              onClick={handleBack}
              className="w-full flex items-center gap-2 h-[3.125rem] text-white/85 border border-white/[.03] rounded-md px-4 py-2 outline-none text-base hover:bg-white/[.05] transition-all"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            >
              <ArrowLeft className="w-5 h-5" />
              Voltar para busca
            </button>
          </div>
        ) : (
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
        )}

        {selectedPlayer ? (
          <motion.div
            initial={{ opacity: 0, scale: 0 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{
              duration: 0.4,
              scale: { type: "spring", visualDuration: 0.4, bounce: 0.2 },
            }}
            className="flex flex-col mt-[.62rem] mx-4"
          >
            <div className="flex items-center justify-center gap-[.62rem]">
              <div
                className="w-[36.4375rem] h-[21.9375rem] rounded-md border border-white/[.03]"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                }}
              >
                <div className="w-full h-[2.6875rem] bg-white/[.02] flex items-center justify-start text-white/55 font-medium text-[0.9375rem] px-[.94rem]">
                  Informações do Jogador
                </div>

                <div className="p-6 space-y-6">
                  {(() => {
                    const player = players.find((p) => p.id === selectedPlayer);
                    if (!player) return null;

                    return (
                      <>
                        {/* Linha 1: Nome, Idade, Gênero, Telefone */}
                        <div className="grid grid-cols-4 gap-4">
                          <div className="space-y-2">
                            <p className="text-white/60 text-sm font-medium">
                              Nome:
                            </p>
                            <div className="flex items-center gap-2">
                              <div className="w-5 h-5 flex items-center justify-center">
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width=".9375rem"
                                  height=".9375rem"
                                  viewBox="0 0 15 15"
                                  fill="none"
                                >
                                  <path
                                    d="M7.5 0C3.35685 0 0 3.35685 0 7.5C0 11.6431 3.35685 15 7.5 15C11.6431 15 15 11.6431 15 7.5C15 3.35685 11.6431 0 7.5 0ZM7.5 2.90323C8.96976 2.90323 10.1613 4.09476 10.1613 5.56452C10.1613 7.03427 8.96976 8.22581 7.5 8.22581C6.03024 8.22581 4.83871 7.03427 4.83871 5.56452C4.83871 4.09476 6.03024 2.90323 7.5 2.90323ZM7.5 13.3065C5.7248 13.3065 4.13407 12.502 3.06956 11.244C3.6381 10.1734 4.75101 9.43548 6.04839 9.43548C6.12097 9.43548 6.19355 9.44758 6.2631 9.46875C6.65625 9.59577 7.06754 9.67742 7.5 9.67742C7.93246 9.67742 8.34677 9.59577 8.73689 9.46875C8.80645 9.44758 8.87903 9.43548 8.95161 9.43548C10.249 9.43548 11.3619 10.1734 11.9304 11.244C10.8659 12.502 9.2752 13.3065 7.5 13.3065Z"
                                    fill="white"
                                  />
                                </svg>
                              </div>
                              <span className="text-white font-bold text-base">
                                {playerDetails?.name ? playerDetails.name.split(' ')[0] : player.name.split(' ')[0]}
                              </span>
                            </div>
                          </div>

                          <div className="space-y-2">
                            <p className="text-white/60 text-sm font-medium">
                              Idade:
                            </p>
                            <div className="flex items-center gap-2">
                              <div className="w-5 h-5 flex items-center justify-center">
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width=".875rem"
                                  height=".9375rem"
                                  viewBox="0 0 14 15"
                                  fill="none"
                                >
                                  <path
                                    d="M3 0.9375V1.875H1.5C0.671875 1.875 0 2.50488 0 3.28125V4.6875H14V3.28125C14 2.50488 13.3281 1.875 12.5 1.875H11V0.9375C11 0.418945 10.5531 0 10 0C9.44687 0 9 0.418945 9 0.9375V1.875H5V0.9375C5 0.418945 4.55312 0 4 0C3.44688 0 3 0.418945 3 0.9375ZM14 5.625H0V13.5938C0 14.3701 0.671875 15 1.5 15H12.5C13.3281 15 14 14.3701 14 13.5938V5.625Z"
                                    fill="white"
                                  />
                                </svg>
                              </div>
                              <span className="text-white font-bold text-base">
                                {playerDetails?.age || 25} Anos
                              </span>
                            </div>
                          </div>

                          <div className="space-y-2">
                            <p className="text-white/60 text-sm font-medium">
                              Gênero:
                            </p>
                            <div className="flex items-center gap-2">
                              <div className="w-5 h-5 bg-white rounded-full flex items-center justify-center">
                                <span className="text-black text-xs">⚥</span>
                              </div>
                              <span className="text-white font-bold text-base">
                                {playerDetails?.gender || "Masculino"}
                              </span>
                            </div>
                          </div>

                          <div className="space-y-2">
                            <p className="text-white/60 text-sm font-medium">
                              Telefone:
                            </p>
                            <div className="flex items-center gap-2">
                              <div className="w-5 h-5 flex items-center justify-center">
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width=".875rem"
                                  height=".875rem"
                                  viewBox="0 0 14 14"
                                  fill="none"
                                >
                                  <path
                                    d="M4.50879 0.673243C4.29825 0.164672 3.74319 -0.106019 3.21275 0.0388961L0.806605 0.695117C0.330845 0.826361 0 1.25837 0 1.75054C0 8.51509 5.48491 14 12.2495 14C12.7416 14 13.1736 13.6692 13.3049 13.1934L13.9611 10.7873C14.106 10.2568 13.8353 9.70175 13.3268 9.49121L10.7019 8.39751C10.2562 8.21158 9.73941 8.34009 9.43591 8.71469L8.33127 10.0627C6.40636 9.15217 4.84783 7.59364 3.93733 5.66873L5.28531 4.56682C5.65991 4.26059 5.78842 3.74655 5.60249 3.30086L4.50879 0.675977V0.673243Z"
                                    fill="white"
                                  />
                                </svg>
                              </div>
                              <span className="text-white font-bold text-base">
                                {playerDetails?.phone || "193-083"}
                              </span>
                            </div>
                          </div>
                        </div>

                        {/* Linha 2: ID, Nacionalidade, Banco, Preso */}
                        <div className="grid grid-cols-4 gap-4">
                          <div className="space-y-2">
                            <p className="text-white/60 text-sm font-medium">
                              ID:
                            </p>
                            <div className="flex items-center gap-2">
                              <div className="w-5 h-5 flex items-center justify-center">
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width="1.1875rem"
                                  height=".9375rem"
                                  viewBox="0 0 19 15"
                                  fill="none"
                                >
                                  <path
                                    d="M2.11111 0C0.946701 0 0 0.960938 0 2.14286V12.8571C0 14.0391 0.946701 15 2.11111 15H16.8889C18.0533 15 19 14.0391 19 12.8571V2.14286C19 0.960938 18.0533 0 16.8889 0H2.11111ZM4.75 8.57143H6.86111C8.3191 8.57143 9.5 9.77009 9.5 11.25C9.5 11.5446 9.2625 11.7857 8.97222 11.7857H2.63889C2.34861 11.7857 2.11111 11.5446 2.11111 11.25C2.11111 9.77009 3.29201 8.57143 4.75 8.57143ZM3.69444 5.35714C3.69444 4.78882 3.91686 4.24378 4.31277 3.84191C4.70868 3.44005 5.24565 3.21429 5.80556 3.21429C6.36546 3.21429 6.90243 3.44005 7.29834 3.84191C7.69425 4.24378 7.91667 4.78882 7.91667 5.35714C7.91667 5.92546 7.69425 6.47051 7.29834 6.87237C6.90243 7.27424 6.36546 7.5 5.80556 7.5C5.24565 7.5 4.70868 7.27424 4.31277 6.87237C3.91686 6.47051 3.69444 5.92546 3.69444 5.35714ZM12.1389 4.28571H16.3611C16.6514 4.28571 16.8889 4.52679 16.8889 4.82143C16.8889 5.11607 16.6514 5.35714 16.3611 5.35714H12.1389C11.8486 5.35714 11.6111 5.11607 11.6111 4.82143C11.6111 4.52679 11.8486 4.28571 12.1389 4.28571ZM12.1389 6.42857H16.3611C16.6514 6.42857 16.8889 6.66964 16.8889 6.96429C16.8889 7.25893 16.6514 7.5 16.3611 7.5H12.1389C11.8486 7.5 11.6111 7.25893 11.6111 6.96429C11.6111 6.66964 11.8486 6.42857 12.1389 6.42857ZM12.1389 8.57143H16.3611C16.6514 8.57143 16.8889 8.8125 16.8889 9.10714C16.8889 9.40179 16.6514 9.64286 16.3611 9.64286H12.1389C11.8486 9.64286 11.6111 9.40179 11.6111 9.10714C11.6111 8.8125 11.8486 8.57143 12.1389 8.57143Z"
                                    fill="white"
                                  />
                                </svg>
                              </div>
                              <span className="text-white font-bold text-base">
                                {playerDetails?.id || player.passport}
                              </span>
                            </div>
                          </div>

                          <div className="space-y-2">
                            <p className="text-white/60 text-sm font-medium">
                              Nacionalidade:
                            </p>
                            <div className="flex items-center gap-2">
                              <div className="w-5 h-5 flex items-center justify-center">
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width=".9375rem"
                                  height=".9375rem"
                                  viewBox="0 0 15 15"
                                  fill="none"
                                >
                                  <path
                                    d="M1.63184 5.85059L2.53711 6.75586C2.71289 6.93164 2.9502 7.03125 3.19922 7.03125H3.8291C4.07812 7.03125 4.31543 7.13086 4.49121 7.30664L5.34961 8.16504C5.52539 8.34082 5.625 8.57812 5.625 8.82715V9.92578C5.625 10.1748 5.72461 10.4121 5.90039 10.5879L6.29004 10.9775C6.46582 11.1533 6.56543 11.3906 6.56543 11.6396V12.1875C6.56543 12.7061 6.98438 13.125 7.50293 13.125C8.02148 13.125 8.44043 12.7061 8.44043 12.1875V12.1084C8.44043 11.8594 8.54004 11.6221 8.71582 11.4463L10.043 10.1191C10.2188 9.94336 10.3184 9.70605 10.3184 9.45703V8.44043C10.3184 7.92188 9.89941 7.50293 9.38086 7.50293H6.95801C6.70898 7.50293 6.47168 7.40332 6.2959 7.22754L5.82715 6.75879C5.7041 6.63574 5.63379 6.46582 5.63379 6.29004C5.63379 5.92383 5.92969 5.62793 6.2959 5.62793H7.3125C7.67871 5.62793 7.97461 5.33203 7.97461 4.96582C7.97461 4.79004 7.9043 4.62012 7.78125 4.49707L7.2041 3.91992C7.08984 3.80859 7.03125 3.66504 7.03125 3.51562C7.03125 3.36621 7.08984 3.22266 7.19824 3.11426L7.70508 2.60742C7.875 2.4375 7.97168 2.20605 7.97168 1.96582C7.97168 1.75488 7.90137 1.56445 7.78418 1.41211C7.69043 1.40918 7.59668 1.40625 7.50293 1.40625C4.70801 1.40625 2.35547 3.28711 1.63477 5.85059H1.63184ZM13.5938 7.5C13.5938 6.48633 13.3477 5.53125 12.9082 4.69336C12.7207 4.71973 12.5361 4.80762 12.3838 4.95996L11.9912 5.35254C11.8154 5.52832 11.7158 5.76562 11.7158 6.01465V7.03125C11.7158 7.5498 12.1348 7.96875 12.6533 7.96875H13.3594C13.4326 7.96875 13.5059 7.95996 13.5732 7.94531C13.585 7.79883 13.5879 7.64941 13.5879 7.5H13.5938ZM0 7.5C0 3.35742 3.35742 0 7.5 0C11.6426 0 15 3.35742 15 7.5C15 11.6426 11.6426 15 7.5 15C3.35742 15 0 11.6426 0 7.5Z"
                                    fill="white"
                                  />
                                </svg>
                              </div>
                              <span className="text-white font-bold text-base">
                                {playerDetails?.nationality || "Brasil"}
                              </span>
                            </div>
                          </div>

                          <div className="space-y-2">
                            <p className="text-white/60 text-sm font-medium">
                              Banco:
                            </p>
                            <div className="flex items-center gap-2">
                              <div className="w-5 h-5 flex items-center justify-center">
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width=".5625rem"
                                  height=".9375rem"
                                  viewBox="0 0 9 15"
                                  fill="none"
                                >
                                  <path
                                    d="M6.53777 6.83789L3.16204 5.91211C2.77133 5.80664 2.4994 5.46387 2.4994 5.08301C2.4994 4.60547 2.91199 4.21875 3.42147 4.21875H5.49379C5.87512 4.21875 6.2502 4.32715 6.56277 4.52637C6.75344 4.64648 7.00974 4.61719 7.17228 4.46777L8.26001 3.47168C8.48193 3.26953 8.45068 2.93262 8.20375 2.75391C7.43796 2.19141 6.4815 1.87793 5.50004 1.875V0.46875C5.50004 0.210938 5.27499 0 4.99994 0H3.99972C3.72466 0 3.49961 0.210938 3.49961 0.46875V1.875H3.42147C1.43042 1.875 -0.169925 3.47754 0.0144896 5.37891C0.145768 6.72949 1.246 7.82813 2.6338 8.20898L5.83762 9.08789C6.22832 9.19629 6.50026 9.53613 6.50026 9.91699C6.50026 10.3945 6.08767 10.7812 5.57818 10.7812H3.50586C3.12453 10.7812 2.74945 10.6729 2.43688 10.4736C2.24622 10.3535 1.98991 10.3828 1.82738 10.5322L0.739645 11.5283C0.517723 11.7305 0.548979 12.0674 0.795907 12.2461C1.5617 12.8086 2.51815 13.1221 3.49961 13.125V14.5312C3.49961 14.7891 3.72466 15 3.99972 15H4.99994C5.27499 15 5.50004 14.7891 5.50004 14.5312V13.1191C6.95661 13.0928 8.32252 12.2812 8.80388 10.9893C9.4759 9.18457 8.34753 7.33301 6.53777 6.83789Z"
                                    fill="white"
                                  />
                                </svg>
                              </div>
                              <span className="text-white font-bold text-base">
                                {playerDetails?.bank ? playerDetails.bank.toLocaleString() : "250.000"}
                              </span>
                            </div>
                          </div>

                          <div className="space-y-2">
                            <p className="text-white/60 text-sm font-medium">
                              Preso:
                            </p>
                            <div className="flex items-center gap-2">
                              <div className="w-5 h-5 flex items-center justify-center">
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width=".9375rem"
                                  height=".9375rem"
                                  viewBox="0 0 15 15"
                                  fill="none"
                                >
                                  <path
                                    d="M8.33333 0.833333C8.33333 0.372396 7.96094 0 7.5 0C7.03906 0 6.66667 0.372396 6.66667 0.833333C6.66667 1.29427 7.03906 1.66667 7.5 1.66667C7.96094 1.66667 8.33333 1.29427 8.33333 0.833333ZM5 3.33333C5.46094 3.33333 5.83333 2.96094 5.83333 2.5C5.83333 2.03906 5.46094 1.66667 5 1.66667C4.53906 1.66667 4.16667 2.03906 4.16667 2.5C4.16667 2.96094 4.53906 3.33333 5 3.33333ZM3.95833 4.16667C3.61198 4.16667 3.33333 4.44531 3.33333 4.79167V5.20833C3.33333 5.23438 3.33594 5.25781 3.33854 5.28385C1.39323 5.96875 0 7.82292 0 10C0 12.7604 2.23958 15 5 15C7.76042 15 10 12.7604 10 10C10 7.82031 8.60677 5.96875 6.66146 5.28385C6.66406 5.26042 6.66667 5.23438 6.66667 5.20833V4.79167C6.66667 4.44531 6.38802 4.16667 6.04167 4.16667H3.95833ZM1.66667 10C1.66667 8.15885 3.15885 6.66667 5 6.66667C6.84115 6.66667 8.33333 8.15885 8.33333 10C8.33333 11.8411 6.84115 13.3333 5 13.3333C3.15885 13.3333 1.66667 11.8411 1.66667 10ZM13.3333 10C13.3333 11.7422 11.9974 13.1719 10.2969 13.3203C9.92448 13.9141 9.45312 14.4427 8.90625 14.8802C9.25781 14.9583 9.625 15 10 15C12.7604 15 15 12.7604 15 10C15 7.82031 13.6068 5.96875 11.6615 5.28385C11.6641 5.26042 11.6667 5.23438 11.6667 5.20833V4.79167C11.6667 4.44531 11.388 4.16667 11.0417 4.16667H8.95833C8.63802 4.16667 8.375 4.40625 8.33854 4.71615C9.1276 5.21615 9.79948 5.88802 10.2969 6.67969C12 6.83073 13.3333 8.25781 13.3333 10ZM10 3.33333C10.4609 3.33333 10.8333 2.96094 10.8333 2.5C10.8333 2.03906 10.4609 1.66667 10 1.66667C9.53906 1.66667 9.16667 2.03906 9.16667 2.5C9.16667 2.96094 9.53906 3.33333 10 3.33333Z"
                                    fill="white"
                                  />
                                </svg>
                              </div>
                              <span className={`font-bold text-base ${playerDetails?.arrested === 'Preso' ? 'text-[#FF4B4B]' : 'text-green-500'}`}>
                                {playerDetails?.arrested || "Livre"}
                              </span>
                            </div>
                          </div>
                        </div>

                        {/* Status Bars */}
                        <div
                          className="grid grid-cols-2 gap-4 rounded border border-white/[.06] p-4"
                          style={{
                            background:
                              "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%)",
                          }}
                        >
                          {/* Coluna esquerda */}
                          <div className="space-y-3">
                            {/* Saúde */}
                            <div className="space-y-1">
                              <div className="flex items-center gap-2">
                                <span className="text-red-400">❤️</span>
                                <span className="text-white/60 text-sm font-medium">
                                  Saúde:
                                </span>
                                <span className="text-white font-bold text-sm ml-auto">
                                  {playerDetails?.stats?.health || 80}%
                                </span>
                              </div>
                              <div className="w-full bg-white/10 rounded-full h-2">
                                <div
                                  className="bg-red-500 h-2 rounded-full"
                                  style={{ width: `${playerDetails?.stats?.health || 80}%` }}
                                ></div>
                              </div>
                            </div>

                            {/* Fome */}
                            <div className="space-y-1">
                              <div className="flex items-center gap-2">
                                <span className="text-orange-400">🍔</span>
                                <span className="text-white/60 text-sm font-medium">
                                  Fome:
                                </span>
                                <span className="text-white font-bold text-sm ml-auto">
                                  {playerDetails?.stats?.hunger || 100}%
                                </span>
                              </div>
                              <div className="w-full bg-white/10 rounded-full h-2">
                                <div
                                  className="bg-orange-500 h-2 rounded-full"
                                  style={{ width: `${playerDetails?.stats?.hunger || 100}%` }}
                                ></div>
                              </div>
                            </div>
                          </div>

                          {/* Coluna direita */}
                          <div className="space-y-3">
                            {/* Colete */}
                            <div className="space-y-1">
                              <div className="flex items-center gap-2">
                                <span className="text-purple-400">🛡️</span>
                                <span className="text-white/60 text-sm font-medium">
                                  Colete:
                                </span>
                                <span className="text-white font-bold text-sm ml-auto">
                                  {playerDetails?.stats?.armour || 50}%
                                </span>
                              </div>
                              <div className="w-full bg-white/10 rounded-full h-2">
                                <div
                                  className="bg-purple-500 h-2 rounded-full"
                                  style={{ width: `${playerDetails?.stats?.armour || 50}%` }}
                                ></div>
                              </div>
                            </div>

                            {/* Sede */}
                            <div className="space-y-1">
                              <div className="flex items-center gap-2">
                                <span className="text-blue-400">💧</span>
                                <span className="text-white/60 text-sm font-medium">
                                  Sede:
                                </span>
                                <span className="text-white font-bold text-sm ml-auto">
                                  {playerDetails?.stats?.thirst || 25}%
                                </span>
                              </div>
                              <div className="w-full bg-white/10 rounded-full h-2">
                                <div
                                  className="bg-blue-500 h-2 rounded-full"
                                  style={{ width: `${playerDetails?.stats?.thirst || 25}%` }}
                                ></div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </>
                    );
                  })()}
                </div>
              </div>

              {/* Container dos Veículos */}
              <div
                className="w-[32.9375rem] h-[21.9375rem] rounded-md border border-white/[.03]"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                }}
              >
                <div className="w-full h-[2.6875rem] bg-white/[.02] flex items-center justify-start text-white/55 font-medium text-[0.9375rem] px-[.94rem]">
                  Veículos Registrados
                </div>

                <div className="p-6 h-[18rem]">
                  <Swiper
                    modules={[Navigation, Pagination]}
                    spaceBetween={20}
                    slidesPerView={1}
                    pagination={{
                      clickable: true,
                      bulletClass:
                        "w-2 h-2 rounded-full bg-white/30 cursor-pointer transition-all",
                      bulletActiveClass: "bg-white",
                    }}
                    className="h-full"
                  >
                    {playerDetails?.vehicles && playerDetails.vehicles.length > 0 ? (
                      playerDetails.vehicles.map((vehicle: any) => (
                        <SwiperSlide key={vehicle.spawn}>
                        <div className="flex flex-col items-start justify-center h-full">
                          {/* Imagem do Veículo */}
                          <div className="w-full flex items-center justify-center mb-4">
                            <img
                              src={vehicle.image}
                              alt={vehicle.name}
                              className="w-[15.5625rem] h-[8.75rem] object-contain"
                                onError={(e) => {
                                  e.currentTarget.src = 'https://via.placeholder.com/248x140/333/fff?text=?';
                                }}
                            />
                          </div>

                          {/* Nome do Veículo */}
                          <h3 className="text-white font-bold text-lg mb-3">
                            {vehicle.name}
                          </h3>

                            {/* Informações do Veículo */}
                            <div className="flex items-center gap-6 text-white/60 text-sm">
                              <div className="flex items-center gap-1">
                                <span>Placa:</span>
                                <span className="text-white font-medium">
                                  {vehicle.plate}
                                </span>
                              </div>
                              <div className="flex items-center gap-1">
                                <span>Cor:</span>
                                <span className="text-white font-medium">
                                  {vehicle.color || "N/A"}
                                </span>
                              </div>
                            </div>
                        </div>
                      </SwiperSlide>
                      ))
                    ) : (
                      <SwiperSlide>
                        <div className="flex flex-col items-center justify-center h-full text-white/60">
                          <p className="text-lg">Nenhum veículo registrado</p>
                        </div>
                      </SwiperSlide>
                    )}
                  </Swiper>
                </div>
              </div>
            </div>
            <div className="flex items-center justify-center gap-[.62rem] mt-[.62rem]">
              {/* Container do Inventário */}
              <div
                className="w-[36.4375rem] h-[17.125rem] rounded-md border border-white/[.03]"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                }}
              >
                <div className="w-full h-[2.6875rem] bg-white/[.02] flex items-center justify-start text-white/55 font-medium text-[0.9375rem] px-[.94rem]">
                  Inventário do Jogador
                </div>

                <div className="mt-[.63rem] ml-[1.06rem] flex-wrap gap-[.63rem] flex max-h-[13rem] overflow-y-auto scrollbar-hide">
                  {playerDetails?.items && playerDetails.items.length > 0 ? (
                    playerDetails.items.map((item: any, index: number) => (
                    <div
                        key={index}
                      className="w-[10.625rem] h-[10.625rem] rounded-md border border-white/[.03] flex flex-col items-center justify-center hover:border-[#df545440]"
                      style={{
                        background:
                          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                      }}
                    >
                      <div className="w-[9.125rem] flex items-center justify-between">
                          <h1 className="text-white text-sm font-bold">{item.quantity}x</h1>
                        <span className="text-white/50 text-sm font-medium">
                            {item.weight || 0}Kg
                        </span>
                      </div>

                        <img
                          src={item.image}
                          alt={item.name}
                          className="size-[6.25rem] my-[.5rem]"
                          onError={(e) => {
                            e.currentTarget.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+Cjx0ZXh0IHg9IjUwIiB5PSI1NSIgZm9udC1mYW1pbHk9IkFyaWFsLCBzYW5zLXNlcmlmIiBmb250LXNpemU9IjQwIiBmaWxsPSIjZmZmZmZmIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj4/PC90ZXh0Pgo8L3N2Zz4K';
                          }}
                        />

                      <div className="w-[9.125rem] flex items-center justify-between">
                        <h1 className="text-white text-sm font-bold">
                          {item.name}
                        </h1>
                        <span className="text-white/50 text-sm font-medium">
                            {item.type || "Usável"}
                        </span>
                      </div>
                    </div>
                    ))
                  ) : (
                    <div className="w-full text-center text-white/60 py-8">
                      Inventário vazio
                    </div>
                  )}
                </div>
              </div>

              {/* Container das Propriedades */}
              <div
                className="w-[32.9375rem] h-[17.125rem] rounded-md border border-white/[.03]"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                }}
              >
                <div className="w-full h-[2.6875rem] bg-white/[.02] flex items-center justify-start text-white/55 font-medium text-[0.9375rem] px-[.94rem]">
                  Propriedades do Jogador
                </div>

                <div className="mt-[.63rem] ml-[1.06rem] flex-wrap gap-[.63rem] flex max-h-[13rem] overflow-y-auto scrollbar-hide">
                  {playerDetails?.properties && playerDetails.properties.length > 0 ? (
                    playerDetails.properties.map((property: any, index: number) => (
                    <div
                        key={index}
                      className="w-[9.875rem] h-[12.375rem] rounded-md border border-white/[.03] flex flex-col items-center justify-center hover:border-[#df545440]"
                      style={{
                        background:
                          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                      }}
                    >
                      <h2 className="text-white text-[0.8125rem] font-bold">
                          {property.type || "Propriedade"}
                      </h2>
                      <p className="text-[#FFFFFF80] truncate max-w-[8rem] text-[0.9375rem]">
                        {property.name}
                      </p>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="6.375rem"
                        height="6.25rem"
                        viewBox="0 0 102 100"
                        fill="none"
                      >
                        <g filter="url(#filter0_d_75_9117)">
                          <path
                            d="M49.2118 30.668C50.2207 29.7773 51.7793 29.7773 52.78 30.668L60.1873 37.2077V36.2467C60.1873 34.8638 61.3603 33.7465 62.8123 33.7465H65.4372C66.8891 33.7465 68.0621 34.8638 68.0621 36.2467V44.1772L71.1629 46.9196C71.9503 47.6228 72.2128 48.7089 71.8191 49.6621C71.4254 50.6153 70.4574 51.2482 69.3746 51.2482H68.0621V64.9995C68.0621 67.7576 65.7079 70 62.8123 70H39.1877C36.2921 70 33.9379 67.7576 33.9379 64.9995V51.2482H32.6254C31.5426 51.2482 30.5746 50.6153 30.1809 49.6621C29.7872 48.7089 30.0496 47.615 30.8371 46.9196L49.2118 30.668ZM55.5937 49.998C55.5937 47.5837 53.5347 45.6226 51 45.6226C48.4653 45.6226 46.4063 47.5837 46.4063 49.998C46.4063 52.4123 48.4653 54.3735 51 54.3735C53.5347 54.3735 55.5937 52.4123 55.5937 49.998ZM41.8127 63.7494C41.8127 64.437 42.4033 64.9995 43.1252 64.9995H58.8748C59.5967 64.9995 60.1873 64.437 60.1873 63.7494C60.1873 60.2959 57.2507 57.4988 53.6249 57.4988H48.3751C44.7493 57.4988 41.8127 60.2959 41.8127 63.7494Z"
                            fill="#df5454"
                          />
                        </g>
                        <defs>
                          <filter
                            id="filter0_d_75_9117"
                            x="0"
                            y="0"
                            width="102"
                            height="100"
                            filterUnits="userSpaceOnUse"
                            color-interpolation-filters="sRGB"
                          >
                            <feFlood
                              flood-opacity="0"
                              result="BackgroundImageFix"
                            />
                            <feColorMatrix
                              in="SourceAlpha"
                              type="matrix"
                              values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                              result="hardAlpha"
                            />
                            <feOffset />
                            <feGaussianBlur stdDeviation="15" />
                            <feComposite in2="hardAlpha" operator="out" />
                            <feColorMatrix
                              type="matrix"
                              values="0 0 0 0 0.235294 0 0 0 0 0.556863 0 0 0 0 0.862745 0 0 0 0.4 0"
                            />
                            <feBlend
                              mode="normal"
                              in2="BackgroundImageFix"
                              result="effect1_dropShadow_75_9117"
                            />
                            <feBlend
                              mode="normal"
                              in="SourceGraphic"
                              in2="effect1_dropShadow_75_9117"
                              result="shape"
                            />
                          </filter>
                        </defs>
                      </svg>

                      <button className="flex items-center justify-center w-[9.125rem] h-8 rounded border border-white/[.05] bg-white/[.01] hover:bg-[#df5454] text-white/35 text-sm font-bold hover:text-white cursor-pointer transition-all mt-1">
                        MARCAR NO MAPA
                      </button>
                    </div>
                    ))
                  ) : (
                    <div className="w-full text-center text-white/60 py-8">
                      Nenhuma propriedade registrada
                    </div>
                  )}
                </div>
              </div>
            </div>
          </motion.div>
        ) : (
          <div className="overflow-y-auto h-[43.6875rem] scrollbar-hide">
            <Table className="leading-[2.75rem] bg-[#FFFFFF03] w-[69.9375rem] m-4 border border-white/[.03] rounded-[0.375rem]">
              <TableHeader className="bg-[#FFFFFF05] text-white/60 text-[0.9375rem] font-bold">
                <TableRow>
                  <TableHead>NOME</TableHead>
                  <TableHead>PROFISSÃO</TableHead>
                  <TableHead>PASSAPORTE</TableHead>
                  <TableHead>VIP</TableHead>
                  <TableHead>STATUS</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {players.length === 0 ? (
                  <TableRow>
                    <TableCell colSpan={5} className="text-center py-8">
                      <span className="text-white/60">Nenhum jogador encontrado</span>
                    </TableCell>
                  </TableRow>
                ) : (
                  players.map((player) => (
                  <React.Fragment key={player.id}>
                    <TableRow
                      className="cursor-pointer"
                      onClick={() =>
                        setExpandedRow(
                          expandedRow === player.id ? null : player.id
                        )
                      }
                    >
                      <TableCell className="text-white text-base font-medium">
                        {player.name}
                      </TableCell>
                      <TableCell>
                        {(() => {
                          const professionColor = getProfessionColor(
                            player.professionColor
                          );
                          return (
                            <div
                              className="inline-flex p-[0.6875rem] h-[2.0625rem] items-center justify-center gap-2 rounded border border-white/[.05] text-sm"
                              style={{
                                background: professionColor.bg,
                                color: professionColor.color,
                                fontWeight: 500,
                              }}
                            >
                              {player.profession}
                            </div>
                          );
                        })()}
                      </TableCell>
                      <TableCell>
                        {" "}
                        <div className="inline-flex items-start justify-start p-[0.625rem] rounded border border-white/[.03] bg-white/[.03] text-[#C7C7C7] text-sm font-bold">
                          {player.passport}
                        </div>
                      </TableCell>
                      <TableCell>
                        {(() => {
                          const vipColor = getVipColor(player.vipColor);
                          return (
                            <div
                              className="inline-flex p-[0.6875rem] h-[2.0625rem] items-center justify-center gap-2 rounded border border-white/[.05] text-sm"
                              style={{
                                background: vipColor.bg,
                                color: vipColor.color,
                                fontWeight: 500,
                              }}
                            >
                              {player.vip}
                            </div>
                          );
                        })()}
                      </TableCell>
                      <TableCell className="text-white">
                        {(() => {
                          const status = getStatusColor(player.status);
                          return (
                            <div
                              className="inline-flex p-[0.6875rem] h-[2.0625rem] items-center justify-center gap-2 rounded border border-white/[.05] text-sm"
                              style={{
                                background: status.bg,
                                color: status.color,
                                fontWeight: 500,
                              }}
                            >
                              <span
                                className="w-2 h-2 rounded-full"
                                style={{
                                  background: status.color,
                                }}
                              />
                              {player.status}
                            </div>
                          );
                        })()}
                      </TableCell>
                    </TableRow>
                    {expandedRow === player.id && (
                      <TableRow>
                        <TableCell colSpan={5}>
                          <div className="flex flex-wrap gap-2 py-2">
                            {actions.map((action, index) => (
                              <button
                                key={index}
                                className="flex items-center justify-center px-3 py-[.88rem] rounded border border-white/[.05] bg-white/[.01] hover:bg-[#df5454] text-white/35 text-sm font-bold hover:text-white cursor-pointer transition-all"
                                onClick={() => action.onClick(player.id)}
                              >
                                {action.name}
                              </button>
                            ))}
                          </div>
                        </TableCell>
                      </TableRow>
                    )}
                  </React.Fragment>
                  ))
                )}
              </TableBody>
            </Table>
          </div>
        )}
      </motion.div>
      <Modal
        open={modalSetVehicleOpen}
        onClose={() => setModalSetVehicleOpen(false)}
      >
        <div className="w-full p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="w-12 h-12 flex items-center justify-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="3.125rem"
                height="2.875rem"
                viewBox="0 0 50 46"
                fill="none"
              >
                <g filter="url(#filter0_d_130_1215)">
                  <path
                    d="M20.2812 18.05L19.2617 20.7143H30.7383L29.7188 18.05C29.543 17.5929 29.0703 17.2857 28.5391 17.2857H21.4609C20.9297 17.2857 20.457 17.5929 20.2812 18.05ZM16.5469 20.8857L17.9219 17.2964C18.4492 15.9214 19.8672 15 21.4609 15H28.5391C30.1328 15 31.5508 15.9214 32.0781 17.2964L33.4531 20.8857C34.3594 21.2286 35 22.0464 35 23V28.1429V29.8571C35 30.4893 34.4414 31 33.75 31H32.5C31.8086 31 31.25 30.4893 31.25 29.8571V28.1429H18.75V29.8571C18.75 30.4893 18.1914 31 17.5 31H16.25C15.5586 31 15 30.4893 15 29.8571V28.1429V23C15 22.0464 15.6406 21.2286 16.5469 20.8857ZM20 24.1429C20 23.8398 19.8683 23.5491 19.6339 23.3347C19.3995 23.1204 19.0815 23 18.75 23C18.4185 23 18.1005 23.1204 17.8661 23.3347C17.6317 23.5491 17.5 23.8398 17.5 24.1429C17.5 24.446 17.6317 24.7367 17.8661 24.951C18.1005 25.1653 18.4185 25.2857 18.75 25.2857C19.0815 25.2857 19.3995 25.1653 19.6339 24.951C19.8683 24.7367 20 24.446 20 24.1429ZM31.25 25.2857C31.5815 25.2857 31.8995 25.1653 32.1339 24.951C32.3683 24.7367 32.5 24.446 32.5 24.1429C32.5 23.8398 32.3683 23.5491 32.1339 23.3347C31.8995 23.1204 31.5815 23 31.25 23C30.9185 23 30.6005 23.1204 30.3661 23.3347C30.1317 23.5491 30 23.8398 30 24.1429C30 24.446 30.1317 24.7367 30.3661 24.951C30.6005 25.1653 30.9185 25.2857 31.25 25.2857Z"
                    fill="#df5454"
                  />
                  <path
                    d="M21.4609 15.5H28.5391C29.9476 15.5 31.1657 16.3136 31.6113 17.4756L32.9863 21.0645L33.0664 21.2744L33.2764 21.3535C34.0164 21.6336 34.5 22.2831 34.5 23V29.8574C34.4998 30.1721 34.2082 30.5 33.75 30.5H32.5C32.0418 30.5 31.7502 30.1721 31.75 29.8574V27.6426H18.25V29.8574C18.2498 30.1721 17.9582 30.5 17.5 30.5H16.25C15.7918 30.5 15.5002 30.1721 15.5 29.8574V23C15.5 22.2831 15.9836 21.6336 16.7236 21.3535L16.9336 21.2744L17.0137 21.0645L18.3887 17.4756C18.8343 16.3136 20.0524 15.5 21.4609 15.5ZM18.75 22.5C18.2996 22.5 17.8592 22.6633 17.5283 22.9658C17.1961 23.2697 17.0001 23.6919 17 24.1426C17 24.5935 17.1959 25.0164 17.5283 25.3203C17.8592 25.6229 18.2996 25.7861 18.75 25.7861C19.2004 25.7861 19.6408 25.6229 19.9717 25.3203C20.3041 25.0164 20.5 24.5935 20.5 24.1426C20.4999 23.6919 20.3039 23.2697 19.9717 22.9658C19.6408 22.6633 19.2004 22.5 18.75 22.5ZM31.25 22.5C30.7996 22.5 30.3592 22.6633 30.0283 22.9658C29.6961 23.2697 29.5001 23.6919 29.5 24.1426C29.5 24.5935 29.6959 25.0164 30.0283 25.3203C30.3592 25.6229 30.7996 25.7861 31.25 25.7861C31.7004 25.7861 32.1408 25.6229 32.4717 25.3203C32.8041 25.0164 33 24.5935 33 24.1426C32.9999 23.6919 32.8039 23.2697 32.4717 22.9658C32.1408 22.6633 31.7004 22.5 31.25 22.5ZM21.4609 16.7861C20.7448 16.7861 20.0722 17.2004 19.8145 17.8701V17.8711L18.7949 20.5352L18.5352 21.2139H31.4648L31.2051 20.5352L30.1855 17.8711V17.8701L30.1328 17.748C29.8441 17.1503 29.2106 16.7861 28.5391 16.7861H21.4609Z"
                    stroke="white"
                    stroke-opacity="0.15"
                  />
                </g>
                <defs>
                  <filter
                    id="filter0_d_130_1215"
                    x="0"
                    y="0"
                    width="50"
                    height="46"
                    filterUnits="userSpaceOnUse"
                    color-interpolation-filters="sRGB"
                  >
                    <feFlood flood-opacity="0" result="BackgroundImageFix" />
                    <feColorMatrix
                      in="SourceAlpha"
                      type="matrix"
                      values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                      result="hardAlpha"
                    />
                    <feOffset />
                    <feGaussianBlur stdDeviation="7.5" />
                    <feComposite in2="hardAlpha" operator="out" />
                    <feColorMatrix
                      type="matrix"
                      values="0 0 0 0 0.235294 0 0 0 0 0.556863 0 0 0 0 0.862745 0 0 0 0.35 0"
                    />
                    <feBlend
                      mode="normal"
                      in2="BackgroundImageFix"
                      result="effect1_dropShadow_130_1215"
                    />
                    <feBlend
                      mode="normal"
                      in="SourceGraphic"
                      in2="effect1_dropShadow_130_1215"
                      result="shape"
                    />
                  </filter>
                </defs>
              </svg>
            </div>
            <h2 className="text-white text-lg font-bold">Setar Veículo</h2>
          </div>

          <div className="mb-4">
            <label className="block text-white/60 text-sm font-medium mb-2">
              ID do jogador
            </label>
            <input
              type="text"
              placeholder="EX: 0"
              value={vehiclePlayerId}
              onChange={(e) => setVehiclePlayerId(e.target.value)}
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          <div className="mb-6">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Spawn do veículo
            </label>
            <input
              type="text"
              placeholder="EX: kuruma"
              value={vehicleSpawn}
              onChange={(e) => setVehicleSpawn(e.target.value)}
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          <div className="mb-8">
            <div className="flex items-center gap-2">
              {[
                { label: "7 Dias", value: 7 },
                { label: "15 Dias", value: 15 },
                { label: "21 Dias", value: 21 },
                { label: "30 Dias", value: 30 },
              ].map((option) => (
                <label
                  key={option.value}
                  className="flex items-center gap-2 cursor-pointer"
                >
                  <div className="relative">
                    <input
                      type="checkbox"
                      checked={selectedDays === option.value}
                      onChange={() => setSelectedDays(option.value)}
                      className="sr-only"
                    />
                    <div
                      className={`w-5 h-5 rounded border-2 flex items-center justify-center transition-colors ${
                        selectedDays === option.value
                          ? "bg-[#df5454] border-[#df5454]"
                          : "bg-transparent border-white/20 hover:border-white/40"
                      }`}
                    >
                      {selectedDays === option.value && (
                        <svg
                          width="12"
                          height="9"
                          viewBox="0 0 12 9"
                          fill="none"
                        >
                          <path
                            d="M1 4.5L4.5 8L11 1"
                            stroke="white"
                            strokeWidth="2"
                            strokeLinecap="round"
                            strokeLinejoin="round"
                          />
                        </svg>
                      )}
                    </div>
                  </div>
                  <span
                    className={`text-sm font-medium ${
                      selectedDays === option.value
                        ? "text-white"
                        : "text-white/60"
                    }`}
                  >
                    {option.label}
                  </span>
                </label>
              ))}
            </div>
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => setModalSetVehicleOpen(false)}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors"
            >
              CANCELAR
            </button>
            <button
              onClick={() => {
                if (vehiclePlayerId && vehicleSpawn) {
                  fetchNui("addVehicleToUser", {
                    vehicle: { spawn: vehicleSpawn },
                    userId: parseInt(vehiclePlayerId),
                    duration: selectedDays
                  });
                  setModalSetVehicleOpen(false);
                  setVehiclePlayerId("");
                  setVehicleSpawn("");
                }
              }}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors"
            >
              CRIAR
            </button>
          </div>
        </div>
      </Modal>

      <Modal
        open={modalSendItemOpen}
        onClose={() => setModalSendItemOpen(false)}
      >
        <div className="w-full p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="w-6 h-6 flex items-center justify-center">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="#df5454">
                <path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z" />
              </svg>
            </div>
            <h2 className="text-white text-lg font-bold">Enviar Item</h2>
          </div>

          <div className="mb-4">
            <label className="block text-white/60 text-sm font-medium mb-2">
              ID do jogador
            </label>
            <input
              type="text"
              placeholder="EX: 0"
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          <div className="mb-4">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Spawn do item
            </label>
            <input
              type="text"
              placeholder="EX: weapon_assaultrifle_mk2"
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          <div className="mb-8">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Quantidade do item
            </label>
            <div className="relative">
              <input
                type="number"
                value={itemQuantity}
                onChange={(e) => setItemQuantity(parseInt(e.target.value))}
                min={1}
                className="w-full h-12 px-4 pr-10 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
              />
              <button
                onClick={() => setItemQuantity(1)}
                className="absolute right-3 top-1/2 transform -translate-y-1/2 text-white/40 hover:text-white/60 transition-colors"
              >
                ×
              </button>
            </div>
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => setModalSendItemOpen(false)}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors"
            >
              CANCELAR
            </button>
            <button
              onClick={() => {
                // Lógica para enviar item
                console.log("Quantidade:", itemQuantity);
                setModalSendItemOpen(false);
              }}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors"
            >
              CRIAR
            </button>
          </div>
        </div>
      </Modal>

    </>
  );
}
