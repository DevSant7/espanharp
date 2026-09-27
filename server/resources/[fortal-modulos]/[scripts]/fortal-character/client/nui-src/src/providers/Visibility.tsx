import React from "react";
import { cn, isEnvBrowser } from "@/utils/misc";
import { useLocation, useNavigate } from "react-router-dom";

import { AnimationProvider } from "./Animation";
import { Post } from "@/hooks/post";
import { observe } from "@/hooks/observe";
import { listen } from "@/hooks/listen";

import Popup from "@/components/Popup";
import Notifys from "@/components/Notifys";

export const VisibilityProvider = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  const navigate = useNavigate();
  const location = useLocation();
  const visible = location.pathname.length > 2;

  observe<string | false>("setVisibility", (route) => {
    navigate(`/${route || ""}`, { replace: true });
  });

  observe<string>("setColor", (data) => {
    document.documentElement.style.setProperty("--main-color", data);
  });

  listen<KeyboardEvent>("keydown", (e) => {
    if (visible && ["Escape"].includes(e.code)) Post.create("removeFocus");
  });

  return (
    <AnimationProvider show={visible}>
      <div
        className={cn("h-screen", {
          "bg-gray-600": isEnvBrowser(),
        })}
      >
        {children}
        <Popup />
        <Notifys />
      </div>
    </AnimationProvider>
  );
};
