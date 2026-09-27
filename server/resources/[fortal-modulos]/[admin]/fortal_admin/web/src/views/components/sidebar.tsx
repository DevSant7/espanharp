import Logo from "@views/assets/logo.png";
import SidebarIcon from "@views/assets/SidebarIcon";
import { Separator } from "./ui/separator";
import SidebarItem from "./SidebarItem";
import PlayersIcon from "@views/assets/PlayersIcon";
import DashboardIcon from "@views/assets/DashboardIcon";
import InventoryIcon from "@views/assets/InventoryIcon";
import VehiclesIcon from "@views/assets/VehiclesIcon";
import HousesIcon from "@views/assets/HousesIcon";
import SalaryIcon from "@views/assets/SalaryIcon";
import StaffIcon from "@views/assets/StaffIcon";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { useState } from "react";

interface UserInfo {
  id: number;
  name: string;
  permission: string;
}

const Sidebar: React.FC = () => {
  const [userInfo, setUserInfo] = useState<UserInfo | null>(null);

  useNuiEvent("receiveUserInfo", (info: UserInfo) => {
    console.log("[FORTAL-ADMIN DEBUG] Sidebar recebeu userInfo:", info);
    setUserInfo(info);
  });

  return (
    <div className="flex flex-col items-center justify-center w-[16.3125rem]">
      <div className="w-full flex items-center justify-between pl-4">
        <div className="flex items-center justify-center size-[2.125rem] rounded-md bg-[#df5454]">
          <img src={Logo} alt="Logo" className="w-[1.0625rem] h-[1.1875rem]" />
        </div>

        <h1 className="text-white text-[1.1rem] font-bold ml-[.94rem]">
          Painel Admin
        </h1>

        <SidebarIcon />
      </div>

      <Separator className="mb-4 w-full h-[0.0625rem] bg-[#FFFFFF08]" />

      <div className="w-full flex flex-col items-start pl-4">
        <div className="w-[14.375rem] flex items-center justify-between mb-4">
          <h1 className="text-white/50 text-sm font-bold">Principal</h1>
          <span className="text-white/35 text-sm font-medium">3</span>
        </div>

        <div className="flex flex-col gap-[.44rem] w-full mb-4">
          <SidebarItem icon={<DashboardIcon />} text="Dashboard" to="/home" />
          <SidebarItem icon={<PlayersIcon />} text="Jogadores" to="/players" />
          <SidebarItem
            icon={<PlayersIcon />}
            text="Organizações"
            to="/organizations"
          />
        </div>

        <div className="w-[14.375rem] flex items-center justify-between mb-4">
          <h1 className="text-white/50 text-sm font-bold">Outros</h1>
          <span className="text-white/35 text-sm font-medium">4</span>
        </div>

        <div className="flex flex-col gap-[.44rem] w-full mb-4">
          <SidebarItem icon={<SalaryIcon />} text="Salário" to="/salary" />
          <SidebarItem
            icon={<InventoryIcon />}
            text="Inventário"
            to="/inventory"
          />
          <SidebarItem icon={<VehiclesIcon />} text="Veículos" to="/vehicles" />
          <SidebarItem
            icon={<HousesIcon />}
            text="Propriedades"
            to="/properties"
          />
        </div>

        <div className="w-[14.375rem] flex items-center justify-between mb-4">
          <h1 className="text-white/50 text-sm font-bold">Administração</h1>
          <span className="text-white/35 text-sm font-medium">1</span>
        </div>

        <div className="flex flex-col gap-[.44rem] w-full mb-4">
          <SidebarItem icon={<StaffIcon />} text="Equipe Staff" to="/staff" />
        </div>

        <Separator className="mb-2 w-full h-[0.0625rem] bg-[#FFFFFF08]" />

        <div className="w-[14.375rem] flex items-center justify-between mb-2">
          <h1 className="text-white/50 text-sm font-bold">Contato</h1>
          <span className="text-white/35 text-sm font-medium">Discord</span>
        </div>

        <div className="flex flex-col gap-[.44rem] w-full mb-4">
          <SidebarItem
            icon={<StaffIcon />}
            text="Discord.gg/fortal"
            to="/staff"
          />
        </div>

        <div className="flex items-center justify-center gap-4">
          <div className="relative size-[3rem] rounded-full border border-white/15">
            <div className="w-full h-full rounded-full overflow-hidden">
              <img
                src="https://i.pravatar.cc/150?img=1"
                alt={userInfo?.name || "Usuário"}
                className="w-full h-full object-cover"
              />
            </div>
            <div className="absolute -bottom-2 left-1/2 -translate-x-1/2 h-[1.25rem] bg-[#df5454] rounded-[0.25rem] inline-flex items-center justify-center p-[0.3125rem] text-white text-xs font-bold">
              #{userInfo?.id || "..."}
            </div>
          </div>
          <div className="flex flex-col items-start justify-start">
            <div className="flex items-center justify-start gap-2">
              <h1 className="text-white text-base font-bold">{userInfo?.name || "Carregando..."}</h1>
            </div>
            <span className="text-white/65 text-sm font-medium">
              {userInfo?.permission || "Admin"}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Sidebar;
