import { compareDesc, format, parseISO } from "date-fns";
import { warnsMockup } from "@/mockUp";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";

import { Chart } from "./components/Chart";
import { ISelectedStatistics } from "@/types";
import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import { useAnnounceFrame } from "@/stores/useHome";
import { usePermissions } from "@/providers/Permissions";

export const Home = () => {
  const { current: announce, set: setAnnounce } = useAnnounceFrame();
  const navigate = useNavigate();
  const location = useLocation();
  const { canPerformAction } = usePermissions();

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: location },
    });
  };

  useEffect(() => {
    Post.create("getWarns", {}, warnsMockup).then((resp: any) => {
      setAnnounce(resp);
    });
  }, []);

  // Listener para atualização em tempo real - simplificado
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === 'updateWarns') {
        if (Array.isArray(event.data.data)) {
          setAnnounce(event.data.data);
        }
      }
    };
    
    window.addEventListener('message', handleMessage);
    
    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, [setAnnounce]);

  const [, setStatisticsFormatted] = useState<ISelectedStatistics[]>([]);
  const [selectedStatistics, setSelectedStatistics] =
    useState<ISelectedStatistics>();

  useEffect(() => {
    const getData = async () => {
      const statistics = await Post.create(
        "getStatistics",
        {},
        [], // Removido mockup
      );

      if (statistics && statistics.length > 0) {
        const statisticsFormatted = statistics.sort((a: any, b: any) =>
          compareDesc(parseISO(a.date), parseISO(b.date)),
        );
        setStatisticsFormatted(statisticsFormatted);

        if (statisticsFormatted.length)
          return setSelectedStatistics(statisticsFormatted[0]);
      }
    };
    getData();
  }, []);

  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.home className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          Área Inicial
        </h1>
      </Title>
      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        <div className="h-[13vw] w-full rounded-[.3vw] border border-[#FFFFFF08] bg-section">
          <div className="flex h-[2.3vw] w-full items-center justify-between bg-[#FFFFFF05] px-[1vw]">
            <h1 className="text-[.8vw] text-white">Quadro de avisos</h1>
            {canPerformAction('canAnnounce') && (
              <button onClick={() => openModal("/panel/modal")}>
                <Icon.add className="w-[.8vw] text-[#59585F] hover:text-white" />
              </button>
            )}
          </div>
          <div className="flex h-[calc(100%-2.3vw)] w-full p-[.5vw]">
            <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
              {Array.isArray(announce) ? announce.map((data) => {
          
                const parsedDate = parseISO(data.createdAt);
                const formattedDate = format(parsedDate, "dd/LL/uuuu");

                
                return (
                <div key={data.id} className="w-[53vw] flex-none border-b border-solid border-[#FFFFFF0D] pb-[.5vw]">
                  <p className="text-[.7vw] text-[#FFFFFF8C]">
                    {formattedDate}
                  </p>
                  <h1 className="text-[.8vw] font-semibold text-white">
                    {data.title}
                  </h1>
                  <p className="text-[.7vw] text-[#FFFFFFBF]">
                    {data.description}
                  </p>
                </div>
                );
              }) : (
                <div className="text-[.8vw] text-[#FFFFFF8C]">
                  Carregando avisos...
                </div>
              )}
            </div>
          </div>
        </div>
        <div className="mt-[.5vw] flex h-[calc(100%-13.5vw)] w-full flex-col gap-[.5vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section">
          <div className="flex h-[2.3vw] w-full items-center justify-between bg-[#FFFFFF05] px-[1vw]">
            <h1 className="text-[.8vw] text-white">Gráfico de Estatísticas</h1>
            <button className="h-[1.5vw] w-[2.5vw] rounded-[.3vw] border border-[#FFFFFF08] bg-section text-[.7vw] leading-none text-[#FFFFFFA6]">
              MÊS
            </button>
          </div>
          <Chart selectedStatistics={selectedStatistics || { date: '', data: [] }} />
        </div>
      </div>
    </div>
  );
};
