import { useLocation, useNavigate } from "react-router-dom";
import { useWantedUser, useWantedVehicle } from "@/stores/useWanted";
import { wantedUserMockup, wantedVehicleMockup } from "@/mockUp";

import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import { useEffect } from "react";
import { usePermissions } from "@/providers/Permissions";

export function Wanted() {
  const { current: vehicles, set: setVehicles } = useWantedVehicle();
  const { current: users, set: setUsers } = useWantedUser();
  const navigate = useNavigate();
  const location = useLocation();
  const { canPerformAction } = usePermissions();

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: location },
    });
  };

  useEffect(() => {
    Post.create("getWantedUsers", {}, wantedUserMockup).then((resp: any) => {
      setUsers(resp);
    });
    Post.create("getWantedVehicles", {}, wantedVehicleMockup).then(
      (resp: any) => {
        setVehicles(resp);
      },
    );

    // Listeners para atualização em tempo real
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === 'updateWantedUsers') {
      
        setUsers(event.data.data);
      }
      
      if (event.data.action === 'updateWantedVehicles') {
        
        setVehicles(event.data.data);
      }
    };

    window.addEventListener('message', handleMessage);
    
    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, [setUsers, setVehicles]);

  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.star className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          Procurados
        </h1>
      </Title>
      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
          <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
            <h1 className="text-[.8vw] text-white">Procurados pela justiça</h1>
            {canPerformAction('canWanted') && (
              <button onClick={() => openModal("/panel/wanted/modaluser")}>
                <Icon.add className="size-[.8vw] text-[#59585F] hover:text-white" />
              </button>
            )}
          </div>

          <div className="relative flex h-[12.5vw] w-full p-[.5vw]">
            {users.length > 0 ? (
              <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto pr-[.5vw]">
                {users.map((data) => (
                  <div className="flex h-[5.5vw] w-full flex-none items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] bg-section p-[.5vw]">
                    <div className="flex h-full w-[4.5vw] items-center justify-center rounded-[.3vw] border border-[#FFFFFF0D] bg-[#FFFFFF05]">
                      {data.photo ? (
                        <img
                          src={data.photo}
                          className="h-full w-full"
                          alt=""
                        />
                      ) : (
                        <svg
                          width="1.25vw"
                          height="1.9vw"
                          viewBox="0 0 24 38"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <path
                            d="M5.33333 10.8632C5.33333 7.86967 7.725 5.43584 10.6667 5.43584H13.3333C16.275 5.43584 18.6667 7.86967 18.6667 10.8632V11.1685C18.6667 13.0172 17.7417 14.7387 16.2167 15.7309L12.7 18.029C10.6 19.4028 9.33333 21.7688 9.33333 24.3044V24.4231C9.33333 25.9241 10.525 27.1368 12 27.1368C13.475 27.1368 14.6667 25.9241 14.6667 24.4231V24.3044C14.6667 23.609 15.0167 22.9645 15.5833 22.5914L19.1 20.2932C22.15 18.2919 24 14.8574 24 11.16V10.8547C24 4.85918 19.225 0 13.3333 0H10.6667C4.775 0.00848025 0 4.86766 0 10.8632C0 12.3642 1.19167 13.5769 2.66667 13.5769C4.14167 13.5769 5.33333 12.3642 5.33333 10.8632ZM12 38C12.8841 38 13.7319 37.6426 14.357 37.0065C14.9821 36.3703 15.3333 35.5075 15.3333 34.6079C15.3333 33.7083 14.9821 32.8455 14.357 32.2093C13.7319 31.5732 12.8841 31.2158 12 31.2158C11.1159 31.2158 10.2681 31.5732 9.64298 32.2093C9.01786 32.8455 8.66667 33.7083 8.66667 34.6079C8.66667 35.5075 9.01786 36.3703 9.64298 37.0065C10.2681 37.6426 11.1159 38 12 38Z"
                            fill="white"
                            fill-opacity="0.65"
                          />
                        </svg>
                      )}
                    </div>
                    <div className="flex h-full w-[48vw] items-center justify-between">
                      <div>
                        <p className="text-[.7vw] leading-none text-[#FFFFFF4D]">
                          PROCURADO
                        </p>
                        <h1 className="text-[.8vw] font-[700] text-white">
                          {data.name}
                        </h1>
                        <div className="mt-[.2vw] w-fit rounded-[.3vw] bg-primary px-[.5vw] py-[.2vw] shadow-[0px_0px_15px_0] shadow-primary/70">
                          <h1 className="text-[.8vw] text-white">
                            {data.date}
                          </h1>
                        </div>
                      </div>
                      <div>
                        <p className="text-[.7vw] leading-none text-[#FFFFFF4D]">
                          Descrição
                        </p>
                        <h1 className="w-[21vw] text-[.8vw] font-[700] text-white">
                          {data.description}
                        </h1>
                      </div>
                      <div className="text-center">
                        <p className="text-[.7vw] leading-none text-[#FFFFFF4D]">
                          Visto por último
                        </p>
                        <h1 className="text-[.8vw] font-[700] text-white">
                          {data.lastSeen}
                        </h1>
                      </div>
                      <div className="mr-[1vw] text-center">
                        <p className="text-[.7vw] leading-none text-[#FFFFFF4D]">
                          Local
                        </p>
                        <h1 className="text-[.8vw] font-[700] text-white">
                          {data.location}
                        </h1>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <h1 className="absolute left-[50%] top-[50%] translate-x-[-50%] translate-y-[-50%] text-[.8vw] text-[#FFFFFF73]">
                Sem novos procurados Fique atento para futuras atualizações.
              </h1>
            )}
          </div>
        </div>
        <div className="mt-[.5vw] w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
          <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
            <h1 className="text-[.8vw] text-white">Veículos Procurados</h1>
            <button onClick={() => openModal("/panel/wanted/modalvehicle")}>
              <Icon.add className="size-[.8vw] text-[#59585F] hover:text-white" />
            </button>
          </div>

          <div className="relative flex h-[12.5vw] w-full p-[.5vw]">
            {vehicles.length > 0 ? (
              <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto pr-[.5vw]">
                {vehicles.map((data) => (
                  <div className="flex h-[5.5vw] w-full flex-none items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF08] bg-section p-[.5vw]">
                    <div className="flex h-full w-[4.5vw] items-center justify-center rounded-[.3vw] border border-[#FFFFFF0D] bg-[#FFFFFF05]">
                      <svg
                        width="1.8vw"
                        height="1.6vw"
                        viewBox="0 0 36 32"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          d="M9.50625 6.1L7.67109 11.4286H28.3289L26.4937 6.1C26.1773 5.18571 25.3266 4.57143 24.3703 4.57143H11.6297C10.6734 4.57143 9.82266 5.18571 9.50625 6.1ZM2.78437 11.7714L5.25938 4.59286C6.20859 1.84286 8.76094 0 11.6297 0H24.3703C27.2391 0 29.7914 1.84286 30.7406 4.59286L33.2156 11.7714C34.8469 12.4571 36 14.0929 36 16V26.2857V29.7143C36 30.9786 34.9945 32 33.75 32H31.5C30.2555 32 29.25 30.9786 29.25 29.7143V26.2857H6.75V29.7143C6.75 30.9786 5.74453 32 4.5 32H2.25C1.00547 32 0 30.9786 0 29.7143V26.2857V16C0 14.0929 1.15312 12.4571 2.78437 11.7714ZM9 18.2857C9 17.6795 8.76295 17.0981 8.34099 16.6695C7.91903 16.2408 7.34674 16 6.75 16C6.15326 16 5.58097 16.2408 5.15901 16.6695C4.73705 17.0981 4.5 17.6795 4.5 18.2857C4.5 18.8919 4.73705 19.4733 5.15901 19.902C5.58097 20.3306 6.15326 20.5714 6.75 20.5714C7.34674 20.5714 7.91903 20.3306 8.34099 19.902C8.76295 19.4733 9 18.8919 9 18.2857ZM29.25 20.5714C29.8467 20.5714 30.419 20.3306 30.841 19.902C31.2629 19.4733 31.5 18.8919 31.5 18.2857C31.5 17.6795 31.2629 17.0981 30.841 16.6695C30.419 16.2408 29.8467 16 29.25 16C28.6533 16 28.081 16.2408 27.659 16.6695C27.2371 17.0981 27 17.6795 27 18.2857C27 18.8919 27.2371 19.4733 27.659 19.902C28.081 20.3306 28.6533 20.5714 29.25 20.5714Z"
                          fill="white"
                          fill-opacity="0.65"
                        />
                      </svg>
                    </div>
                    <div className="flex h-full w-[48vw] items-center justify-between">
                      <div>
                        <p className="text-[.7vw] leading-none text-[#FFFFFF4D]">
                          MODELO
                        </p>
                        <h1 className="text-[.8vw] font-[700] text-white">
                          {data.model}
                        </h1>
                        <div className="mt-[.2vw] w-fit rounded-[.3vw] bg-primary px-[.5vw] py-[.2vw] shadow-[0px_0px_15px_0] shadow-primary/70">
                          <h1 className="text-[.8vw] text-white">
                            {data.date}
                          </h1>
                        </div>
                      </div>
                      <div>
                        <p className="text-[.7vw] leading-none text-[#FFFFFF4D]">
                          Especificações do veículo
                        </p>
                        <h1 className="w-[21vw] text-[.8vw] font-[700] text-white">
                          {data.specifications}
                        </h1>
                      </div>
                      <div className="text-center">
                        <p className="text-[.7vw] leading-none text-[#FFFFFF4D]">
                          Visto por último
                        </p>
                        <h1 className="text-[.8vw] font-[700] text-white">
                          {data.lastSeen}
                        </h1>
                      </div>
                      <div className="mr-[1vw] text-center">
                        <p className="text-[.7vw] leading-none text-[#FFFFFF4D]">
                          Local
                        </p>
                        <h1 className="text-[.8vw] font-[700] text-white">
                          {data.location}
                        </h1>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <h1 className="absolute left-[50%] top-[50%] translate-x-[-50%] translate-y-[-50%] text-[.8vw] text-[#FFFFFF73]">
                Sem novos procurados Fique atento para futuras atualizações.
              </h1>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
