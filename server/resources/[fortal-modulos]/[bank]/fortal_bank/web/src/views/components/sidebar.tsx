import Logo from "@views/assets/logo.png";
import { Separator } from "./ui/separator";
import SidebarItem from "./SidebarItem";
import PlayersIcon from "@views/assets/PlayersIcon";
import DashboardIcon from "@views/assets/DashboardIcon";
import TransferIcon from "@views/assets/TransferIcon";
import InvoiceIcon from "@views/assets/InvoiceIcon";
import FinesIcon from "@views/assets/FinesIcon";
import InvestmentsIcon from "@views/assets/InvestmentsIcon";

const Sidebar: React.FC = () => {
  return (
    <div className="flex flex-col items-center justify-center w-[6rem]">
      <div className="flex items-center justify-center my-4">
        <img src={Logo} alt="Logo" className="size-[2.625rem]" />
      </div>

      <Separator className="mb-4 w-full h-[0.0625rem] bg-[#FFFFFF08]" />

      <div className="w-full flex flex-col items-center justify-center gap-4">
        <SidebarItem icon={<DashboardIcon />} to="/home" />
        <SidebarItem icon={<TransferIcon />} to="/transfer" />
        <SidebarItem icon={<InvoiceIcon />} to="/invoice" />
        <SidebarItem icon={<FinesIcon />} to="/fines" />
        <SidebarItem icon={<InvestmentsIcon />} to="/investments" />
        <SidebarItem icon={<PlayersIcon />} to="/player" />
      </div>
    </div>
  );
};

export default Sidebar;
