import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";

import { Icon } from "@/components/_components/Navigation";
import { Member } from "./_components/Member";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import { useMember } from "@/stores/useMember";
import { usePermissions } from "@/providers/Permissions";

export function Members() {
  const { current: members, set: setMembers } = useMember();
  const [search, setSearch] = useState("");
  const navigate = useNavigate();
  const location = useLocation();
  const { canPerformAction } = usePermissions();

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: location },
    });
  };

  useEffect(() => {
    Post.create("getMembers", {}, []).then((resp: any) => {
      setMembers(resp);
    });

    // Listeners para atualização em tempo real
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === 'updateMembers') {
        setMembers(event.data.data);
      }
    };

    window.addEventListener('message', handleMessage);
    
    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, [setMembers]);

  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.list className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          Gerenciar Membros
        </h1>
      </Title>
      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        <div className="h-[27.3vw] w-full rounded-[.3vw] border border-[#FFFFFF08] bg-section">
          <div className="flex h-[2.5vw] w-full items-center justify-between border-b border-solid border-[#FFFFFF0D] bg-[#FFFFFF05] px-[.8vw]">
            <h1 className="text-[.8vw] text-white">Lista de Membros</h1>
            {canPerformAction('canHire') && (
              <button onClick={() => openModal("/panel/members/modal")}>
                <Icon.add className="w-[.8vw] text-[#59585F]" />
              </button>
            )}
          </div>
          <div className="flex h-[calc(100%-2.5vw)] w-full flex-col overflow-auto">
            <div className="flex h-[2vw] w-full flex-none items-center justify-between border-b border-solid border-[#FFFFFF0D] bg-[#FFFFFF08] px-[.8vw]">
              <h1 className="w-[10.5vw] text-[.8vw] text-white">Nome/ID</h1>
              <h1 className="w-[10.5vw] text-[.8vw] text-white">Patente</h1>
              <h1 className="w-[10.5vw] text-[.8vw] text-white">Desde</h1>
              <h1 className="w-[8vw] text-[.8vw] text-white">Status</h1>
              <h1 className="w-[8vw] text-end text-[.8vw] text-white">Ações</h1>
            </div>
            {members
              .filter(
                (member) =>
                  member.name.includes(search) ||
                  member.id.toString().includes(search),
              )
              .map((data) => (
                <Member data={data} />
              ))}
          </div>
        </div>
        <div className="mt-[.5vw] flex items-center justify-between">
          <div className="flex h-[2.5vw] items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] bg-section px-[.8vw]">
            <Icon.search className="w-[.8vw] text-[#FFFFFF80]" />
            <input
              className="h-full w-[16.5vw] bg-transparent text-[.8vw] text-white placeholder:text-[#FFFFFF80]"
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Buscar (Nome, ID)"
            />
          </div>
          <div className="flex h-[2.5vw] w-[4.5vw] items-center justify-center rounded-[.4vw] border border-[#FFFFFF08] bg-section">
            <h1 className="text-[.8vw] text-[#FFFFFFD9]">
              {members.length}
              <span className="text-[#FFFFFF73]">/100</span>
            </h1>
          </div>
          <button
            onClick={() => Post.create("leaveOrg")}
            className="h-[2.5vw] w-[30vw] rounded-[.4vw] border border-[#FF68680D] bg-out text-[.8vw] text-[#FF6868D9] hover:text-[#FF686880]"
          >
            Clique aqui para encerrar sua participação na corporação.
          </button>
        </div>
      </div>
    </div>
  );
}
