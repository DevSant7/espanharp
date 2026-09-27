import * as motion from "motion/react-client";
import DashboardCard from "@views/components/DashboardCard";
import { Separator } from "@views/components/ui/separator";
import {
  ArrowRight,
  Ban,
  BanIcon,
  Car,
  Megaphone,
  UserMinus,
  UserX,
  WrenchIcon,
  Edit,
  Trash2,
} from "lucide-react";
import { useState, useEffect } from "react";
import { Modal } from "@views/components/modal";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { fetchNui } from "@app/utils/fetchNui";
import { useDashboardRefresh } from "@app/hooks/useAutoRefresh";

interface Notification {
  id: number;
  title: string;
  message: string;
  created_at: string;
  updated_at?: string;
}

interface OnlinePlayersData {
  players: number;
  slots: number;
}

interface ServerData {
  props: number;
  vehicles: number;
}

interface ChatMessage {
  id: number;
  user_id: number;
  name: string;
  message: string;
  created_at: string;
}


export function Home() {
  const [modalAnnouncementOpen, setModalAnnouncementOpen] = useState(false);
  const [modalAnnounceOpen, setModalAnnounceOpen] = useState(false);
  const [modalSetVehicleOpen, setModalSetVehicleOpen] = useState(false);
  const [modalEditNotificationOpen, setModalEditNotificationOpen] = useState(false);
  const [modalDeleteNotificationOpen, setModalDeleteNotificationOpen] = useState(false);
  const [notificationToDelete, setNotificationToDelete] = useState<Notification | null>(null);
  const [selectedDays, setSelectedDays] = useState<number>(15);
  const [chatMessage, setChatMessage] = useState<string>("");
  const [vehiclePlayerId, setVehiclePlayerId] = useState<string>("");
  const [vehicleSpawn, setVehicleSpawn] = useState<string>("");
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [editingNotification, setEditingNotification] = useState<Notification | null>(null);
  const [notificationForm, setNotificationForm] = useState({
    title: "",
    message: "",
  });
  const [loading, setLoading] = useState(false);
  const [resultMessage, setResultMessage] = useState<{ success: boolean; message: string } | null>(null);
  const [onlinePlayersData, setOnlinePlayersData] = useState<OnlinePlayersData>({ players: 0, slots: 0 });
  const [serverData, setServerData] = useState<ServerData>({ props: 0, vehicles: 0 });
  const [announcementForm, setAnnouncementForm] = useState({
    title: "",
    message: "",
  });
  const [announcementLoading, setAnnouncementLoading] = useState(false);
  const [announcementResult, setAnnouncementResult] = useState<{ success: boolean; message: string } | null>(null);
  const [destroyLoading, setDestroyLoading] = useState(false);
  const [cdsInput, setCdsInput] = useState("");
  const [removeWhitelistInput, setRemoveWhitelistInput] = useState("");
  const [addWhitelistInput, setAddWhitelistInput] = useState("");
  const [kickPlayerInput, setKickPlayerInput] = useState("");
  const [revivePlayerInput, setRevivePlayerInput] = useState("");
  const [chatMessages, setChatMessages] = useState<ChatMessage[]>([]);
  const [currentUserId, setCurrentUserId] = useState<number | null>(null);

  // Hook para receber eventos do NUI
  useNuiEvent("updateNotifications", (data: Notification[]) => {
    setNotifications(data);
  });

  useNuiEvent("notificationResult", (result: { success: boolean; message: string }) => {
    setResultMessage(result);
    setLoading(false);
    
    // Fechar modais se sucesso
    if (result.success) {
      setModalAnnouncementOpen(false);
      setModalEditNotificationOpen(false);
      setNotificationForm({ title: "", message: "" });
      setEditingNotification(null);
    }
    
    // Limpar mensagem após 3 segundos
    setTimeout(() => setResultMessage(null), 3000);
  });

  useNuiEvent("receiveNotification", (notification: Notification) => {
    setEditingNotification(notification);
    setNotificationForm({
      title: notification.title,
      message: notification.message,
    });
    setModalEditNotificationOpen(true);
  });

  useNuiEvent("updateOnlinePlayers", (data: OnlinePlayersData) => {
    setOnlinePlayersData(data);
  });

  useNuiEvent("updateServerData", (data: ServerData) => {
    setServerData(data);
  });

  useNuiEvent("receiveChatMessage", (message: ChatMessage) => {
    setChatMessages(prev => [...prev, message]);
  });

  useNuiEvent("receiveChatMessages", (messages: ChatMessage[]) => {
    setChatMessages(messages);
  });

  useNuiEvent("setCurrentUserId", (userId: number) => {
    setCurrentUserId(userId);
  });

  useNuiEvent("announcementResult", (result: { success: boolean; message: string }) => {
    setAnnouncementResult(result);
    setAnnouncementLoading(false);
    
    // Fechar modal se sucesso
    if (result.success) {
      setModalAnnounceOpen(false);
      setAnnouncementForm({ title: "", message: "" });
    }
    
    // Limpar mensagem após 3 segundos
    setTimeout(() => setAnnouncementResult(null), 3000);
  });

  // Funções para gerenciar notificações
  const handleCreateNotification = async () => {
    if (!notificationForm.title.trim() || !notificationForm.message.trim()) {
      setResultMessage({ success: false, message: "Título e mensagem são obrigatórios!" });
      return;
    }

    setLoading(true);
    await fetchNui("createNotification", notificationForm);
  };

  const handleEditNotification = async () => {
    if (!editingNotification || !notificationForm.title.trim() || !notificationForm.message.trim()) {
      setResultMessage({ success: false, message: "Dados inválidos!" });
      return;
    }

    setLoading(true);
    await fetchNui("editNotification", {
      id: editingNotification.id,
      ...notificationForm,
    });
  };

  const handleDeleteNotification = async (notification: Notification) => {
    setNotificationToDelete(notification);
    setModalDeleteNotificationOpen(true);
  };

  const confirmDeleteNotification = async () => {
    if (notificationToDelete) {
      setLoading(true);
      await fetchNui("deleteNotification", { id: notificationToDelete.id });
      setModalDeleteNotificationOpen(false);
      setNotificationToDelete(null);
    }
  };

  const handleEditClick = async (id: number) => {
    await fetchNui("getNotification", { id });
  };

  // Função para criar anúncio
  const handleCreateAnnouncement = async () => {
    if (!announcementForm.title.trim() || !announcementForm.message.trim()) {
      setAnnouncementResult({ success: false, message: "Título e mensagem são obrigatórios!" });
      return;
    }

    setAnnouncementLoading(true);
    await fetchNui("createAnnouncement", announcementForm);
  };

  // Função para destruir todos os veículos
  const handleDestroyVehicles = async () => {
    setDestroyLoading(true);
    await fetchNui("destroyAllVehicles");
    
    // Limpar loading após 2 segundos (tempo para a notificação aparecer)
    setTimeout(() => setDestroyLoading(false), 2000);
  };

  // Função para reparar veículo
  const handleFixVehicle = async () => {
    await fetchNui("fixVehicle");
  };

  // Função para tuning de veículo
  const handleTuningVehicle = async () => {
    await fetchNui("tuningVehicle");
  };

  // Função para teleporte CDS
  const handleTeleportCDS = async () => {
    if (!cdsInput.trim()) {
      return;
    }
    await fetchNui("teleportCDS", { cds: cdsInput.trim() });
    setCdsInput("");
  };

  // Função para remover whitelist
  const handleRemoveWhitelist = async () => {
    console.log("[FORTAL-ADMIN DEBUG] handleRemoveWhitelist chamado! Input:", removeWhitelistInput);
    if (!removeWhitelistInput.trim()) {
      console.log("[FORTAL-ADMIN DEBUG] Input vazio, retornando...");
      return;
    }
    console.log("[FORTAL-ADMIN DEBUG] Enviando fetchNui('removeWhitelist')...");
    await fetchNui("removeWhitelist", { id: removeWhitelistInput.trim() });
    console.log("[FORTAL-ADMIN DEBUG] fetchNui('removeWhitelist') concluído!");
    setRemoveWhitelistInput("");
  };

  // Função para adicionar whitelist
  const handleAddWhitelist = async () => {
    console.log("[FORTAL-ADMIN DEBUG] handleAddWhitelist chamado! Input:", addWhitelistInput);
    if (!addWhitelistInput.trim()) {
      console.log("[FORTAL-ADMIN DEBUG] Input vazio, retornando...");
      return;
    }
    console.log("[FORTAL-ADMIN DEBUG] Enviando fetchNui('addWhitelist')...");
    await fetchNui("addWhitelist", { id: addWhitelistInput.trim() });
    console.log("[FORTAL-ADMIN DEBUG] fetchNui('addWhitelist') concluído!");
    setAddWhitelistInput("");
  };

  // Função para expulsar jogador
  const handleKickPlayer = async () => {
    console.log("[FORTAL-ADMIN DEBUG] handleKickPlayer chamado! Input:", kickPlayerInput);
    if (!kickPlayerInput.trim()) {
      console.log("[FORTAL-ADMIN DEBUG] Input vazio, retornando...");
      return;
    }
    console.log("[FORTAL-ADMIN DEBUG] Enviando fetchNui('kickPlayer')...");
    await fetchNui("kickPlayer", { id: kickPlayerInput.trim() });
    console.log("[FORTAL-ADMIN DEBUG] fetchNui('kickPlayer') concluído!");
    setKickPlayerInput("");
  };

  // Função para reviver jogador
  const handleRevivePlayer = async () => {
    if (!revivePlayerInput.trim()) {
      return;
    }
    await fetchNui("revivePlayer", { id: revivePlayerInput.trim() });
    setRevivePlayerInput("");
  };

  const formatNotificationDate = (dateString: string) => {
    const date = new Date(dateString);
    return {
      date: date.toLocaleDateString("pt-BR"),
      time: date.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" }),
    };
  };

  // Hook para atualizar dados automaticamente quando o painel se tornar visível
  useDashboardRefresh();

  const handleSendMessage = async () => {
    if (chatMessage.trim()) {
      console.log("Enviando mensagem:", chatMessage);
      await fetchNui("sendChatMessage", { message: chatMessage.trim() });
      setChatMessage("");
    }
  };

  // Função para formatar data das mensagens
  const formatMessageTime = (dateString: string) => {
    const date = new Date(dateString);
    const now = new Date();
    const diffInHours = (now.getTime() - date.getTime()) / (1000 * 60 * 60);
    
    if (diffInHours < 24) {
      return date.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });
    } else {
      return date.toLocaleDateString("pt-BR", { day: "2-digit", month: "2-digit" }) + " " + 
             date.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });
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
          Dashboard
        </h1>
        <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF08] mt-[1.2rem]" />

        <div className="flex items-center justify-center gap-[.69rem] mt-4">
          <div className="flex flex-col gap-[.62rem]">
            <div className="flex items-center justify-center gap-[.69rem]">
              <div
                className="relative w-[19.5625rem] h-[7.5rem] flex-shrink-0 rounded-md border border-white/[.03] p-5"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0) 100%), linear-gradient(91deg, rgba(255,255,255,0.01) 0%, rgba(255,255,255,0.01) 100%)",
                }}
              >
                {/* Bloco de textos: ocupa toda a altura e centraliza verticalmente */}
                <div className="h-full flex flex-col justify-center">
                  <span className="text-white/65 text-base font-medium mb-[.5rem]">
                    Players Totais
                  </span>

                  <div className="flex items-end gap-1 mb-[1rem]">
                    <span className="text-white text-[1.375rem] font-bold">
                      {onlinePlayersData.players.toLocaleString()}
                    </span>
                    <span className="text-white/35 text-[1.375rem] font-bold">
                      / {onlinePlayersData.slots.toLocaleString()}
                    </span>
                  </div>

                  <span className="text-white/35 text-sm font-medium">
                    Percentual atualizada a cada uma hora.
                  </span>
                </div>

                <div
                  className="absolute right-[1.25rem] top-[25%] translate-y-[-50%] w-[2.1875rem] h-[2.1875rem] flex items-center justify-center rounded-md border border-white/15"
                  style={{
                    background:
                      "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0) 100%), #df5454",
                  }}
                  aria-hidden
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="1.0625rem"
                    height="1.1875rem"
                    viewBox="0 0 17 19"
                    fill="none"
                  >
                    <path
                      d="M8.5 9.5C9.78819 9.5 11.0236 8.99956 11.9345 8.10876C12.8454 7.21796 13.3571 6.00978 13.3571 4.75C13.3571 3.49022 12.8454 2.28204 11.9345 1.39124C11.0236 0.500445 9.78819 0 8.5 0C7.21181 0 5.97637 0.500445 5.06548 1.39124C4.15459 2.28204 3.64286 3.49022 3.64286 4.75C3.64286 6.00978 4.15459 7.21796 5.06548 8.10876C5.97637 8.99956 7.21181 9.5 8.5 9.5ZM6.76585 11.2812C3.02813 11.2812 0 14.2426 0 17.8979C0 18.5064 0.504688 19 1.12701 19H15.873C16.4953 19 17 18.5064 17 17.8979C17 14.2426 13.9719 11.2812 10.2342 11.2812H6.76585Z"
                      fill="white"
                    />
                  </svg>
                </div>
              </div>
              <div
                className="relative w-[20.75rem] h-[7.5rem] flex-shrink-0 rounded-md border border-white/[.03] p-5"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0) 100%), linear-gradient(91deg, rgba(255,255,255,0.01) 0%, rgba(255,255,255,0.01) 100%)",
                }}
              >
                {/* Bloco de textos: ocupa toda a altura e centraliza verticalmente */}
                <div className="h-full flex flex-col justify-center">
                  <span className="text-white/65 text-base font-medium mb-[.5rem]">
                    Veículos e Objetos
                  </span>

                  <div className="flex items-center justify-start gap-1 mb-[1rem]">
                    <span className="text-white text-[1.375rem] font-bold">
                      {serverData.vehicles.toLocaleString()}
                    </span>
                    <span className="text-white/35 text-base font-medium">
                      Veículos
                    </span>
                    <span className="text-white text-[1.375rem] font-bold ml-[1.31rem]">
                      {serverData.props.toLocaleString()}
                    </span>
                    <span className="text-white/35 text-base font-medium">
                      Objetos
                    </span>
                  </div>

                  <span className="text-white/35 text-sm font-medium">
                    Percentual atualizada a cada uma hora.
                  </span>
                </div>

                <div
                  className="absolute right-[1.25rem] top-[25%] translate-y-[-50%] w-[2.1875rem] h-[2.1875rem] flex items-center justify-center rounded-md border border-white/15"
                  style={{
                    background:
                      "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0) 100%), #df5454",
                  }}
                  aria-hidden
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="1.1875rem"
                    height="1.0625rem"
                    viewBox="0 0 19 17"
                    fill="none"
                  >
                    <path
                      d="M5.01719 3.24063L4.04863 6.07143H14.9514L13.9828 3.24063C13.8158 2.75491 13.3668 2.42857 12.8621 2.42857H6.13789C5.6332 2.42857 5.18418 2.75491 5.01719 3.24063ZM1.46953 6.25357L2.77578 2.43996C3.27676 0.979018 4.62383 0 6.13789 0H12.8621C14.3762 0 15.7232 0.979018 16.2242 2.43996L17.5305 6.25357C18.3914 6.61786 19 7.48683 19 8.5V13.9643V15.7857C19 16.4574 18.4693 17 17.8125 17H16.625C15.9682 17 15.4375 16.4574 15.4375 15.7857V13.9643H3.5625V15.7857C3.5625 16.4574 3.03184 17 2.375 17H1.1875C0.530664 17 0 16.4574 0 15.7857V13.9643V8.5C0 7.48683 0.608594 6.61786 1.46953 6.25357ZM4.75 9.71429C4.75 9.39224 4.62489 9.08338 4.40219 8.85566C4.17949 8.62793 3.87744 8.5 3.5625 8.5C3.24756 8.5 2.94551 8.62793 2.72281 8.85566C2.50011 9.08338 2.375 9.39224 2.375 9.71429C2.375 10.0363 2.50011 10.3452 2.72281 10.5729C2.94551 10.8006 3.24756 10.9286 3.5625 10.9286C3.87744 10.9286 4.17949 10.8006 4.40219 10.5729C4.62489 10.3452 4.75 10.0363 4.75 9.71429ZM15.4375 10.9286C15.7524 10.9286 16.0545 10.8006 16.2772 10.5729C16.4999 10.3452 16.625 10.0363 16.625 9.71429C16.625 9.39224 16.4999 9.08338 16.2772 8.85566C16.0545 8.62793 15.7524 8.5 15.4375 8.5C15.1226 8.5 14.8205 8.62793 14.5978 8.85566C14.3751 9.08338 14.25 9.39224 14.25 9.71429C14.25 10.0363 14.3751 10.3452 14.5978 10.5729C14.8205 10.8006 15.1226 10.9286 15.4375 10.9286Z"
                      fill="white"
                    />
                  </svg>
                </div>
              </div>
            </div>
            <div className="grid grid-cols-3 gap-[.63rem]">
              {/* 1. Card sem input, 1 botão */}
              <DashboardCard
                title="Criar anúncio"
                description="Crie qualquer anúncio para todos os players da cidade."
                icon={<Megaphone size={18} />}
                primaryButtonLabel="CRIAR"
                onPrimaryClick={() => setModalAnnounceOpen(true)}
              />

              {/* 2. Card com input + botão */}
              <div className="w-[13.25rem] h-[8.4375rem] rounded-md border border-[rgba(255,255,255,0.03)] p-[.88rem] flex flex-col justify-between" style={{ background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)" }}>
                {/* Cabeçalho */}
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <h3 className="text-base font-bold text-white/85">Remover Whitelist</h3>
                    <p className="text-[.7125rem] text-white/35 font-medium">
                      Remover a Whitelist do Jogador
                    </p>
                  </div>
                  <div className="text-white/70">
                    <UserMinus size={18} />
                  </div>
                </div>

                {/* Input + Botão */}
                <div className="flex gap-2">
                  <input
                    type="text"
                    placeholder="ID"
                    value={removeWhitelistInput}
                    onChange={(e) => setRemoveWhitelistInput(e.target.value)}
                    className="w-[8.875rem] h-[2.1875rem] rounded border border-white/10 px-2 py-1 text-white focus:outline-none focus:border-white/20 placeholder-white/65 text-base font-bold"
                    style={{
                      background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.06) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                    }}
                  />
                  <button
                    onClick={handleRemoveWhitelist}
                    className="px-2 py-1 text-base font-bold rounded text-white/65 transition border border-white/[.05]"
                    style={{
                      background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                    }}
                  >
                    <ArrowRight className="size-4 text-white" />
                  </button>
                </div>
              </div>

              {/* 3. Card com input + botão */}
              <div className="w-[13.25rem] h-[8.4375rem] rounded-md border border-[rgba(255,255,255,0.03)] p-[.88rem] flex flex-col justify-between" style={{ background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)" }}>
                {/* Cabeçalho */}
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <h3 className="text-base font-bold text-white/85">Expulsar Jogador</h3>
                    <p className="text-[.7125rem] text-white/35 font-medium">
                      Expulsar qualquer jogador da cidade
                    </p>
                  </div>
                  <div className="text-white/70">
                    <UserX size={18} />
                  </div>
                </div>

                {/* Input + Botão */}
                <div className="flex gap-2">
                  <input
                    type="text"
                    placeholder="ID"
                    value={kickPlayerInput}
                    onChange={(e) => setKickPlayerInput(e.target.value)}
                    className="w-[8.875rem] h-[2.1875rem] rounded border border-white/10 px-2 py-1 text-white focus:outline-none focus:border-white/20 placeholder-white/65 text-base font-bold"
                    style={{
                      background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.06) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                    }}
                  />
                  <button
                    onClick={handleKickPlayer}
                    className="px-2 py-1 text-base font-bold rounded text-white/65 transition border border-white/[.05]"
                    style={{
                      background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                    }}
                  >
                    <ArrowRight className="size-4 text-white" />
                  </button>
                </div>
              </div>

              {/* 4. Card com input + botão */}
              <DashboardCard
                title="Banir Jogador"
                description="Banir qualquer jogador da cidade."
                icon={<Ban size={18} />}
                inputPlaceholder="ID"
                primaryButtonLabel={
                  <ArrowRight className="size-4 text-white" />
                }
                onPrimaryClick={() => console.log("Banir Jogador")}
              />

              {/* 5. Card sem input, 1 botão */}
              <DashboardCard
                title="Setar Carro"
                description="Setar um carro para qualquer jogador da cidade."
                icon={<Car size={18} />}
                primaryButtonLabel="SETAR"
                onPrimaryClick={() => setModalSetVehicleOpen(true)}
              />

              {/* 6. Card com input + botão */}
              <DashboardCard
                title="Reviver Jogador"
                description="Reviver qualquer jogador da cidade."
                icon={
                  <svg
                    width={18}
                    height={18}
                    viewBox="0 0 24 24"
                    fill="currentColor"
                  >
                    <path d="M12 2C13.1 2 14 2.9 14 4C14 5.1 13.1 6 12 6C10.9 6 10 5.1 10 4C10 2.9 10.9 2 12 2ZM21 9V7L15 1L13.5 2.5L16.17 5.17C15.24 5.06 14.28 5 13.26 5H12C7.03 5 3 9.03 3 14S7.03 23 12 23S21 18.97 21 14H19C19 17.86 15.86 21 12 21S5 17.86 5 14S8.14 7 12 7H13.26C14.04 7 14.8 7.06 15.54 7.17L18.5 4.5L21 7V9Z" />
                  </svg>
                }
                inputPlaceholder="ID"
                inputValue={revivePlayerInput}
                onInputChange={setRevivePlayerInput}
                primaryButtonLabel={
                  <ArrowRight className="size-4 text-white" />
                }
                onPrimaryClick={handleRevivePlayer}
              />

              {/* 7. Card com input + botão */}
              <DashboardCard
                title="Teleportar"
                description="Teleportar para qualquer jogador da cidade."
                icon={
                  <svg
                    width={18}
                    height={18}
                    viewBox="0 0 24 24"
                    fill="currentColor"
                  >
                    <path d="M12 2A2 2 0 0 1 14 4A2 2 0 0 1 12 6A2 2 0 0 1 10 4A2 2 0 0 1 12 2M21 9V7L15 1L13.5 2.5L16.17 5.17C14.96 5.06 13.71 5 12.41 5H12C7.03 5 3 9.03 3 14S7.03 23 12 23S21 18.97 21 14H19C19 17.86 15.86 21 12 21S5 17.86 5 14S8.14 7 12 7C13.04 7 14.04 7.15 15 7.42V9L21 9Z" />
                  </svg>
                }
                inputPlaceholder="ID"
                primaryButtonLabel={
                  <ArrowRight className="size-4 text-white" />
                }
                onPrimaryClick={() => console.log("Teleportar")}
              />

              {/* 8. Card com input + botão */}
              <DashboardCard
                title="Trazer Jogador"
                description="Trazer qualquer jogador até sua localização."
                icon={
                  <svg
                    width={18}
                    height={18}
                    viewBox="0 0 24 24"
                    fill="currentColor"
                  >
                    <path d="M12 2A2 2 0 0 1 14 4A2 2 0 0 1 12 6A2 2 0 0 1 10 4A2 2 0 0 1 12 2M21 9V7L15 1L13.5 2.5L16.17 5.17C14.96 5.06 13.71 5 12.41 5H12C7.03 5 3 9.03 3 14S7.03 23 12 23S21 18.97 21 14H19C19 17.86 15.86 21 12 21S5 17.86 5 14S8.14 7 12 7C13.04 7 14.04 7.15 15 7.42V9L21 9Z" />
                  </svg>
                }
                inputPlaceholder="ID"
                primaryButtonLabel={
                  <ArrowRight className="size-4 text-white" />
                }
                onPrimaryClick={() => console.log("Trazer Jogador")}
              />

              {/* 9. Card com input + botão */}
              <div className="w-[13.25rem] h-[8.4375rem] rounded-md border border-[rgba(255,255,255,0.03)] p-[.88rem] flex flex-col justify-between" style={{ background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)" }}>
                {/* Cabeçalho */}
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <h3 className="text-base font-bold text-white/85">Teleporte CDS</h3>
                    <p className="text-[.7125rem] text-white/35 font-medium">
                      Teleportar para coordenadas CDS.
                    </p>
                  </div>
                  <div className="text-white/70">
                    <svg width={18} height={18} viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 2L13.09 8.26L22 9L13.09 9.74L12 16L10.91 9.74L2 9L10.91 8.26L12 2Z" />
                  </svg>
                  </div>
                </div>

                {/* Input + Botão */}
                <div className="flex gap-2">
                  <input
                    type="text"
                    placeholder="CDS"
                    value={cdsInput}
                    onChange={(e) => setCdsInput(e.target.value)}
                    className="w-[8.875rem] h-[2.1875rem] rounded border border-white/10 px-2 py-1 text-white focus:outline-none focus:border-white/20 placeholder-white/65 text-base font-bold"
                    style={{
                      background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.06) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                    }}
                  />
                  <button
                    onClick={handleTeleportCDS}
                    className="px-2 py-1 text-base font-bold rounded text-white/65 transition border border-white/[.05]"
                    style={{
                      background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                    }}
                  >
                    <ArrowRight className="size-4 text-white" />
                  </button>
                </div>
              </div>

              {/* 10. Card com input + botão */}
              <div className="w-[13.25rem] h-[8.4375rem] rounded-md border border-[rgba(255,255,255,0.03)] p-[.88rem] flex flex-col justify-between" style={{ background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)" }}>
                {/* Cabeçalho */}
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <h3 className="text-base font-bold text-white/85">Liberar Whitelist</h3>
                    <p className="text-[.7125rem] text-white/35 font-medium">
                      Libere a Whitelist usando ID da tabela accounts
                    </p>
                  </div>
                  <div className="text-white/70">
                    <svg width={18} height={18} viewBox="0 0 24 24" fill="currentColor">
                    <path d="M9,22A1,1 0 0,1 8,21V18H4A2,2 0 0,1 2,16V4C2,2.89 2.9,2 4,2H20A2,2 0 0,1 22,4V16A2,2 0 0,1 20,18H13.9L10.2,21.71C10,21.9 9.75,22 9.5,22V22H9M10.5,16L18,8.5L16.5,7L10.5,13L7.5,10L6,11.5L10.5,16Z" />
                  </svg>
                  </div>
                </div>

                {/* Input + Botão */}
                <div className="flex gap-2">
                  <input
                    type="text"
                    placeholder="ID"
                    value={addWhitelistInput}
                    onChange={(e) => setAddWhitelistInput(e.target.value)}
                    className="w-[8.875rem] h-[2.1875rem] rounded border border-white/10 px-2 py-1 text-white focus:outline-none focus:border-white/20 placeholder-white/65 text-base font-bold"
                    style={{
                      background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.06) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                    }}
                  />
                  <button
                    onClick={handleAddWhitelist}
                    className="px-2 py-1 text-base font-bold rounded text-white/65 transition border border-white/[.05]"
                    style={{
                      background: "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                    }}
                  >
                    <ArrowRight className="size-4 text-white" />
                  </button>
                </div>
              </div>

              {/* 11. Card com dois botões */}
              <DashboardCard
                title="Fix & Tunning"
                description="Reparar ou tungar qualquer carro da cidade."
                icon={<WrenchIcon size={18} />}
                primaryButtonLabel="FIX"
                onPrimaryClick={handleFixVehicle}
                secondaryButtonLabel="TUNNING"
                onSecondaryClick={handleTuningVehicle}
              />

              {/* 12. Card sem input, 1 botão */}
              <DashboardCard
                title="Destruir Veículos"
                description="Destrua todos os veículos Spawnados na cidade."
                icon={
                  <svg
                    width={18}
                    height={18}
                    viewBox="0 0 24 24"
                    fill="currentColor"
                  >
                    <path d="M6,2A2,2 0 0,0 4,4V20A2,2 0 0,0 6,22H18A2,2 0 0,0 20,20V8L14,2H6M6,4H13V9H18V20H6V4M8.93,12.22H10.66L12.5,9.67L14.34,12.22H16.07L13.5,8.31L16.07,4.39H14.34L12.5,6.94L10.66,4.39H8.93L11.5,8.31L8.93,12.22Z" />
                  </svg>
                }
                primaryButtonLabel={
                  destroyLoading ? (
                    <div className="flex items-center gap-2">
                      <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      DESTRUINDO...
                    </div>
                  ) : (
                    "DESTRUIR"
                  )
                }
                onPrimaryClick={handleDestroyVehicles}
              />
            </div>
          </div>
          <div className="flex flex-col gap-[.69rem]">
            <div
              className="w-[28.3125rem] h-[13.6875rem] rounded-md border border-white/[.03]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            >
              <div className="w-full h-[2.625rem] rounded-t-md bg-white/[0.02] flex items-center justify-between px-[.88rem]">
                <h1 className="text-white text-base font-medium">
                  Quadro de avisos
                </h1>

                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="1rem"
                  height="1rem"
                  viewBox="0 0 16 16"
                  fill="none"
                  className="cursor-pointer hover:rotate-90 transition-transform duration-300"
                  onClick={() => setModalAnnouncementOpen(true)}
                >
                  <rect x="7" width="2" height="16" fill="#AFAFB1" />
                  <rect y="7" width="16" height="2" fill="#AFAFB1" />
                </svg>
              </div>

              <div className="h-[9.8125rem] overflow-y-auto scrollbar-hide flex flex-col gap-4 w-full">
                {notifications.length === 0 ? (
                  <div className="w-full px-4 py-[.94rem] flex items-center justify-center">
                    <p className="text-white/50 text-sm font-medium">Nenhum aviso encontrado</p>
                  </div>
                ) : (
                  notifications.map((notification) => {
                    const { date, time } = formatNotificationDate(notification.created_at);
                    return (
                      <div
                        key={notification.id}
                        className="w-full px-4 py-[.94rem] border-b border-white/[.05] last:border-0 group relative"
                      >
                        <div className="w-full">
                          <div className="flex-1 pr-10">
                    <span className="text-white/55 text-[0.9375rem] font-medium mb-[.94rem]">
                              {date}
                    </span>

                      <h2 className="text-white text-base font-bold mb-1">
                              {notification.title}{" "}
                        <span className="text-white/65 text-sm font-medium">
                                {time}
                        </span>
                      </h2>
                    <p className="text-white/75 text-sm font-medium">
                              {notification.message}
                            </p>
                  </div>
                        </div>
                        
                        {/* Botões de ação (aparecem no hover) */}
                        <div className="opacity-0 group-hover:opacity-100 transition-opacity duration-200 flex gap-1 absolute right-1 top-[.8rem]">
                          <button
                            onClick={() => handleEditClick(notification.id)}
                            className="w-6 h-6 flex items-center justify-center rounded bg-white/10 hover:bg-white/20 transition-colors"
                            title="Editar aviso"
                          >
                            <Edit size={12} className="text-white/70" />
                          </button>
                          <button
                            onClick={() => handleDeleteNotification(notification)}
                            className="w-6 h-6 flex items-center justify-center rounded bg-red-500/20 hover:bg-red-500/30 transition-colors"
                            title="Deletar aviso"
                          >
                            <Trash2 size={12} className="text-red-400" />
                          </button>
                        </div>
                      </div>
                    );
                  })
                )}
              </div>
            </div>
            <div
              className="w-[28.3125rem] h-[29.375rem] rounded-md border border-white/[.03] relative flex flex-col"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            >
              {/* Header */}
              <div className="w-full h-[2.625rem] rounded-t-md bg-white/[0.02] flex items-center justify-between px-[.88rem]">
                <h1 className="text-white text-base font-medium">Chat Staff</h1>
              </div>

              {/* Chat Messages Area */}
              <div className="flex-1 overflow-y-auto scrollbar-hide px-4 py-3 space-y-4">
                {chatMessages.map((msg) => {
                  const isOwn = currentUserId && msg.user_id === currentUserId;
                  return (
                  <div
                    key={msg.id}
                    className={`flex ${
                        isOwn ? "flex-row-reverse" : "flex-row"
                    } gap-3`}
                  >
                    {/* Avatar */}
                    <div className="w-10 h-10 rounded-full overflow-hidden flex-shrink-0">
                      <img
                          src="https://i.pravatar.cc/150?img=1"
                          alt={msg.name}
                        className="w-full h-full object-cover"
                      />
                    </div>

                    {/* Message Content */}
                    <div
                      className={`flex flex-col ${
                          isOwn ? "items-end" : "items-start"
                      } max-w-[70%]`}
                    >
                      <div className="flex items-center gap-2 mb-1">
                        <span className="text-white text-sm font-bold">
                            {msg.name}
                        </span>
                        <span className="text-white/50 text-xs">
                            {formatMessageTime(msg.created_at)}
                        </span>
                      </div>
                      <div
                        className={`px-3 py-2 rounded-lg text-white/90 text-sm leading-relaxed ${
                            isOwn
                            ? "bg-[#df5454] rounded-br-sm"
                            : "bg-white/10 rounded-bl-sm"
                        }`}
                      >
                        {msg.message}
                      </div>
                    </div>
                  </div>
                  );
                })}
              </div>

              {/* Chat Input Area */}
              <div className="w-full h-[4.3125rem] rounded-b-[0.375rem] bg-white/[0.02] flex items-center px-4 gap-3">
                <div className="flex-1 relative">
                  <input
                    type="text"
                    value={chatMessage}
                    onChange={(e) => setChatMessage(e.target.value)}
                    onKeyPress={(e) => e.key === "Enter" && handleSendMessage()}
                    placeholder="Conversar em #chat-staff"
                    className="w-full h-10 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
                  />
                </div>
                <button
                  onClick={handleSendMessage}
                  className="w-10 h-10 rounded-md bg-[#df5454] hover:bg-[#3577C7] transition-colors flex items-center justify-center"
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="white">
                    <path d="M2.01 21L23 12 2.01 3 2 10l15 2-15 2z" />
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>
      </motion.div>

      <Modal
        open={modalAnnouncementOpen}
        onClose={() => setModalAnnouncementOpen(false)}
      >
        <div className="w-full p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="w-6 h-6 flex items-center justify-center">
              <svg
                width="1.25rem"
                height="1.25rem"
                viewBox="0 0 24 24"
                fill="#df5454"
              >
                <path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z" />
              </svg>
            </div>
            <h2 className="text-white text-lg font-bold">Criar Aviso</h2>
          </div>

          {/* Mensagem de resultado */}
          {resultMessage && (
            <div className={`mb-4 p-3 rounded-md text-sm font-medium ${
              resultMessage.success 
                ? "bg-green-500/20 text-green-400 border border-green-500/30" 
                : "bg-red-500/20 text-red-400 border border-red-500/30"
            }`}>
              {resultMessage.message}
            </div>
          )}

          <div className="mb-4">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Título
            </label>
            <input
              type="text"
              value={notificationForm.title}
              onChange={(e) => setNotificationForm(prev => ({ ...prev, title: e.target.value }))}
              placeholder="EX: Preciso da administração reunida hoje!"
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          <div className="mb-8">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Mensagem
            </label>
            <textarea
              value={notificationForm.message}
              onChange={(e) => setNotificationForm(prev => ({ ...prev, message: e.target.value }))}
              placeholder="Ex: Todos tem de estar reunidos no dia de hoje às 12:30 para termos uma conversa bem séria!"
              className="w-full h-32 px-4 py-3 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors resize-none"
            />
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => {
                setModalAnnouncementOpen(false);
                setNotificationForm({ title: "", message: "" });
                setResultMessage(null);
              }}
              disabled={loading}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors disabled:opacity-50"
            >
              CANCELAR
            </button>
            <button
              onClick={handleCreateNotification}
              disabled={loading}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
            >
              {loading ? (
                <>
                  <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  CRIANDO...
                </>
              ) : (
                "CRIAR"
              )}
            </button>
          </div>
        </div>
      </Modal>

      <Modal
        open={modalAnnounceOpen}
        onClose={() => setModalAnnounceOpen(false)}
      >
        <div className="w-full p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="flex items-center justify-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="3.125rem"
                height="3.125rem"
                viewBox="0 0 50 50"
                fill="none"
              >
                <g filter="url(#filter0_d_130_655)">
                  <path
                    d="M33.75 16.252C33.75 15.7482 33.4453 15.2912 32.9766 15.0959C32.5078 14.9006 31.9727 15.01 31.6133 15.3654L29.9102 17.0723C28.0352 18.9471 25.4922 20.0016 22.8398 20.0016H22.5H21.25H17.5C16.1211 20.0016 15 21.1226 15 22.5014V26.251C15 27.6297 16.1211 28.7507 17.5 28.7507V33.7501C17.5 34.4415 18.0586 35 18.75 35H21.25C21.9414 35 22.5 34.4415 22.5 33.7501V28.7507H22.8398C25.4922 28.7507 28.0352 29.8053 29.9102 31.68L31.6133 33.383C31.9727 33.7423 32.5078 33.8478 32.9766 33.6525C33.4453 33.4572 33.75 33.0041 33.75 32.4964V26.7314C34.4766 26.3877 35 25.462 35 24.3722C35 23.2825 34.4766 22.3568 33.75 22.0131V16.252ZM31.25 19.2478V24.3762V29.5045C28.9531 27.4149 25.957 26.251 22.8398 26.251H22.5V22.5014H22.8398C25.957 22.5014 28.9531 21.3374 31.25 19.2478Z"
                    fill="#df5454"
                  />
                  <path
                    d="M30.9131 18.8779C28.7081 20.8839 25.8322 22.001 22.8398 22.001H22V26.751H22.8398C25.8321 26.751 28.7081 27.8682 30.9131 29.874L31.75 30.6357V18.1172L30.9131 18.8779ZM18 28.251H17.5C16.3972 28.251 15.5 27.3535 15.5 26.251V22.501C15.5002 21.3986 16.3973 20.502 17.5 20.502H22.8398C25.4508 20.502 27.9611 19.5287 29.8867 17.7852L30.2637 17.4258L31.9648 15.7207C32.1834 15.5046 32.5048 15.4412 32.7842 15.5576C33.0674 15.6756 33.25 15.9509 33.25 16.252V22.3301L33.5361 22.4648C34.0412 22.7038 34.4999 23.418 34.5 24.3721C34.5 25.3262 34.0412 26.0404 33.5361 26.2793L33.25 26.415V32.4961C33.25 32.8002 33.0683 33.073 32.7842 33.1914C32.5023 33.3087 32.1827 33.2452 31.9668 33.0293L30.2637 31.3262C28.295 29.3578 25.6249 28.251 22.8398 28.251H22V33.75C22 34.1651 21.6653 34.5 21.25 34.5H18.75C18.3347 34.5 18 34.1651 18 33.75V28.251Z"
                    stroke="white"
                    stroke-opacity="0.15"
                  />
                </g>
                <defs>
                  <filter
                    id="filter0_d_130_655"
                    x="0"
                    y="0"
                    width="50"
                    height="50"
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
                      result="effect1_dropShadow_130_655"
                    />
                    <feBlend
                      mode="normal"
                      in="SourceGraphic"
                      in2="effect1_dropShadow_130_655"
                      result="shape"
                    />
                  </filter>
                </defs>
              </svg>
            </div>
            <h2 className="text-white text-lg font-bold">Criar Anúncio</h2>
          </div>

          {/* Mensagem de resultado */}
          {announcementResult && (
            <div className={`mb-4 p-3 rounded-md text-sm font-medium ${
              announcementResult.success 
                ? "bg-green-500/20 text-green-400 border border-green-500/30" 
                : "bg-red-500/20 text-red-400 border border-red-500/30"
            }`}>
              {announcementResult.message}
            </div>
          )}

          <div className="mb-4">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Título
            </label>
            <input
              type="text"
              value={announcementForm.title}
              onChange={(e) => setAnnouncementForm(prev => ({ ...prev, title: e.target.value }))}
              placeholder="EX: Evento"
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          <div className="mb-8">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Mensagem
            </label>
            <textarea
              value={announcementForm.message}
              onChange={(e) => setAnnouncementForm(prev => ({ ...prev, message: e.target.value }))}
              placeholder="Ex: Ocorrerá as 19:30 do dia 23/09!"
              className="w-full h-32 px-4 py-3 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors resize-none"
            />
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => {
                setModalAnnounceOpen(false);
                setAnnouncementForm({ title: "", message: "" });
                setAnnouncementResult(null);
              }}
              disabled={announcementLoading}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors disabled:opacity-50"
            >
              CANCELAR
            </button>
            <button
              onClick={handleCreateAnnouncement}
              disabled={announcementLoading}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
            >
              {announcementLoading ? (
                <>
                  <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  ENVIANDO...
                </>
              ) : (
                "CRIAR"
              )}
            </button>
          </div>
        </div>
      </Modal>

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

      {/* Modal de Edição de Aviso */}
      <Modal
        open={modalEditNotificationOpen}
        onClose={() => {
          setModalEditNotificationOpen(false);
          setEditingNotification(null);
          setNotificationForm({ title: "", message: "" });
          setResultMessage(null);
        }}
      >
        <div className="w-full p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="w-6 h-6 flex items-center justify-center">
              <Edit size={20} className="text-[#df5454]" />
            </div>
            <h2 className="text-white text-lg font-bold">Editar Aviso</h2>
          </div>

          {/* Mensagem de resultado */}
          {resultMessage && (
            <div className={`mb-4 p-3 rounded-md text-sm font-medium ${
              resultMessage.success 
                ? "bg-green-500/20 text-green-400 border border-green-500/30" 
                : "bg-red-500/20 text-red-400 border border-red-500/30"
            }`}>
              {resultMessage.message}
            </div>
          )}

          <div className="mb-4">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Título
            </label>
            <input
              type="text"
              value={notificationForm.title}
              onChange={(e) => setNotificationForm(prev => ({ ...prev, title: e.target.value }))}
              placeholder="EX: Preciso da administração reunida hoje!"
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          <div className="mb-8">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Mensagem
            </label>
            <textarea
              value={notificationForm.message}
              onChange={(e) => setNotificationForm(prev => ({ ...prev, message: e.target.value }))}
              placeholder="Ex: Todos tem de estar reunidos no dia de hoje às 12:30 para termos uma conversa bem séria!"
              className="w-full h-32 px-4 py-3 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors resize-none"
            />
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => {
                setModalEditNotificationOpen(false);
                setEditingNotification(null);
                setNotificationForm({ title: "", message: "" });
                setResultMessage(null);
              }}
              disabled={loading}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors disabled:opacity-50"
            >
              CANCELAR
            </button>
            <button
              onClick={handleEditNotification}
              disabled={loading}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
            >
              {loading ? (
                <>
                  <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  SALVANDO...
                </>
              ) : (
                "SALVAR"
              )}
            </button>
          </div>
        </div>
      </Modal>

      {/* Modal de Confirmação de Exclusão */}
      <Modal
        open={modalDeleteNotificationOpen}
        onClose={() => {
          setModalDeleteNotificationOpen(false);
          setNotificationToDelete(null);
        }}
      >
        <div className="w-full p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="w-6 h-6 flex items-center justify-center">
              <Trash2 size={20} className="text-red-400" />
            </div>
            <h2 className="text-white text-lg font-bold">Confirmar Exclusão</h2>
          </div>

          <div className="mb-6">
            <p className="text-white/80 text-sm leading-relaxed">
              Tem certeza que deseja deletar este aviso?
            </p>
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={() => {
                setModalDeleteNotificationOpen(false);
                setNotificationToDelete(null);
              }}
              disabled={loading}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors disabled:opacity-50"
            >
              CANCELAR
            </button>
            <button
              onClick={confirmDeleteNotification}
              disabled={loading}
              className="flex-1 h-12 rounded-md bg-red-500 text-white font-bold hover:bg-red-600 transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
            >
              {loading ? (
                <>
                  <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  DELETANDO...
                </>
              ) : (
                "DELETAR"
              )}
            </button>
          </div>
        </div>
      </Modal>
    </>
  );
}
