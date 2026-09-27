import React, { createContext, useEffect, useState } from "react";

import { AnimationProvider } from "./Animation";
import { Post } from "@/hooks/post";
import { isEnvBrowser } from "@/utils/misc";
import { useNavigate } from "react-router-dom";

export interface NuiVisibilityFrame {
  route: string | null;
  setRoute: (path: string | null) => void;
}

export const VisibilityContext = createContext<NuiVisibilityFrame | null>(null);

export const VisibilityProvider = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  const [route, setRoute] = useState<string | null>(null);
  const navigate = useNavigate();


  // Simplificado - apenas um useEffect básico
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
     
      
      if (event.data.action === 'setVisibility') {
        if (event.data.data === null || event.data.data === undefined || event.data.data === '') {
          setRoute(null);
        } else if (event.data.data) {
          setRoute(event.data.data);
        }
      }
      
      if (event.data.action === 'setColor') {
        document.documentElement.style.setProperty("--main-color", event.data.data);
      }

      if (event.data.action === 'closeModal') {
        
        navigate(-1);
      }

      if (event.data.action === 'clearSelections') {
       
        // Limpar seleções usando os stores
        // Isso será tratado pelos próprios stores
      }
    };

    const handleKeydown = (e: KeyboardEvent) => {
      if (route && ["Escape"].includes(e.code)) {
       
        setRoute(null);
      }
    };

    window.addEventListener('message', handleMessage);
    window.addEventListener('keydown', handleKeydown);
    
    return () => {
      window.removeEventListener('message', handleMessage);
      window.removeEventListener('keydown', handleKeydown);
    };
  }, [route, navigate]);

  useEffect(() => {
    if (!route && !isEnvBrowser()) {
      Post.create("removeFocus");
    }
  }, [route]);

  return (
    <VisibilityContext.Provider
      value={{
        route,
        setRoute,
      }}
    >
      <AnimationProvider show={!!route}>
        {children}
      </AnimationProvider>
    </VisibilityContext.Provider>
  );
};
