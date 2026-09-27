import React from "react";
import { useLocation, useNavigate } from "react-router-dom";

interface SidebarItemProps {
  icon: React.ReactNode;
  text: string;
  to: string;
}

const SidebarItem: React.FC<SidebarItemProps> = ({ icon, text, to }) => {
  const location = useLocation();
  const navigate = useNavigate();
  const isActive = location.pathname === to;

  const buttonClass = [
    "group w-[14.375rem] h-[2.75rem] flex items-center px-4 gap-3 transition-all rounded-[0.375rem] border",
    isActive
      ? "border-[rgba(255,255,255,0.15)] bg-[#df5454]"
      : "border-[rgba(255,255,255,0.05)] bg-[radial-gradient(95.47%_60.03%_at_49.84%_76.67%,rgba(255,255,255,0.06)_0%,rgba(255,255,255,0)_100%),linear-gradient(91deg,rgba(255,255,255,0.01)_0%,rgba(255,255,255,0.01)_100%)] hover:border-[rgba(255,255,255,0.15)] hover:bg-[#df5454]",
  ].join(" ");

  const textClass = [
    isActive
      ? "text-white text-[1rem] font-medium"
      : "text-[rgba(255,255,255,0.65)] text-[1rem] font-medium group-hover:text-white",
  ].join(" ");

  return (
    <button onClick={() => navigate(to)} className={buttonClass}>
      <div className="flex items-center gap-3 w-full">
        <span className="flex items-center">{icon}</span>
        <span className={textClass}>{text}</span>
      </div>
    </button>
  );
};

export default SidebarItem;
