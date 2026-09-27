import React from "react";
import { useLocation, useNavigate } from "react-router-dom";

interface SidebarItemProps {
  icon: React.ReactNode;
  to: string;
}

const SidebarItem: React.FC<SidebarItemProps> = ({ icon, to }) => {
  const location = useLocation();
  const navigate = useNavigate();
  const isActive = location.pathname === to;

  const buttonClass = [
    "group size-[2.5rem] flex items-center justify-center px-4 gap-3 transition-all rounded-[0.375rem] border",
    isActive
      ? "border-[rgba(255,255,255,0.15)] bg-[#df5454]"
      : "border-[rgba(255,255,255,0.08)] hover:border-[rgba(255,255,255,0.15)] hover:bg-[#df5454]",
  ].join(" ");

  return (
    <button onClick={() => navigate(to)} className={buttonClass}>
      <span className="flex items-center">{icon}</span>
    </button>
  );
};

export default SidebarItem;
