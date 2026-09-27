import { useState } from "react";
import loginBg from "@views/assets/loginBg.png";
import logo from "@views/assets/logo.png";
import { useNavigate } from "react-router-dom";
import { useUserData } from "../../../hooks/useUserData";
import { useJointAccounts } from "../../../hooks/useJointAccounts";
import { UserAvatar } from "@views/components/UserAvatar";

type Account = {
  id: string;
  name: string;
  subtitle?: string;
  avatar?: string;
  type?: "personal" | "shared" | "joint";
};

function AccountRow({
  a,
  onOpen,
}: {
  a: Account;
  onOpen: (id: string) => void;
}) {
  return (
    <div
      onClick={() => onOpen(a.id)}
      className="w-full flex items-center gap-4 p-4 cursor-pointer transition"
      style={{
        borderRadius: "0.5625rem",
        border: "1px solid rgba(255,255,255,0.03)",
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
      }}
    >
      <UserAvatar size="lg" />
      <div className="flex-1 text-left">
        <div style={{ color: "#FFF", fontSize: "0.875rem", fontWeight: 500 }}>
          {a.name}
        </div>
        {a.subtitle && (
          <div className="flex items-center justify-start text-xs text-white/60">
            {a.subtitle}
            {a.type === "shared" && (
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="1.875rem"
                height="1.9375rem"
                viewBox="0 0 30 31"
                fill="none"
              >
                <g filter="url(#filter0_d_176_83)">
                  <path
                    d="M14.4781 12.3746H16.0438L17.7607 10.6542C17.8092 10.6053 17.867 10.5666 17.9306 10.5401C17.9942 10.5136 18.0624 10.5 18.1313 10.5C18.2002 10.5 18.2684 10.5136 18.332 10.5401C18.3956 10.5666 18.4533 10.6053 18.5018 10.6542L19.8482 12.0045C19.9454 12.1021 20 12.2343 20 12.372C20 12.5097 19.9454 12.6419 19.8482 12.7395L18.6531 13.9386H14.4781V14.9813C14.4781 15.1195 14.4231 15.2521 14.3253 15.3499C14.2274 15.4477 14.0947 15.5026 13.9562 15.5026C13.8178 15.5026 13.6851 15.4477 13.5872 15.3499C13.4894 15.2521 13.4344 15.1195 13.4344 14.9813V13.4173C13.4344 13.1407 13.5443 12.8755 13.7401 12.68C13.9358 12.4845 14.2013 12.3746 14.4781 12.3746ZM11.3469 14.9813V17.0666L10.1518 18.2605C10.0546 18.3581 10 18.4903 10 18.628C10 18.7657 10.0546 18.8979 10.1518 18.9955L11.4982 20.3458C11.5467 20.3947 11.6044 20.4334 11.668 20.4599C11.7316 20.4864 11.7998 20.5 11.8687 20.5C11.9376 20.5 12.0058 20.4864 12.0694 20.4599C12.133 20.4334 12.1908 20.3947 12.2393 20.3458L14.4781 18.1093H16.5656C16.704 18.1093 16.8368 18.0543 16.9347 17.9566C17.0325 17.8588 17.0875 17.7262 17.0875 17.5879V17.0666H17.6094C17.7478 17.0666 17.8805 17.0117 17.9784 16.9139C18.0763 16.8161 18.1313 16.6835 18.1313 16.5453V16.0239H18.6531C18.7916 16.0239 18.9243 15.969 19.0222 15.8712C19.12 15.7735 19.175 15.6409 19.175 15.5026V14.9813H15.5219V15.5026C15.5219 15.7791 15.4119 16.0443 15.2162 16.2399C15.0204 16.4354 14.7549 16.5453 14.4781 16.5453H13.4344C13.1575 16.5453 12.8921 16.4354 12.6963 16.2399C12.5006 16.0443 12.3906 15.7791 12.3906 15.5026V13.9386L11.3469 14.9813Z"
                    fill="white"
                    fill-opacity="0.5"
                    shape-rendering="crispEdges"
                  />
                </g>
                <defs>
                  <filter
                    id="filter0_d_176_83"
                    x="0"
                    y="0.5"
                    width="30"
                    height="30"
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
                    <feGaussianBlur stdDeviation="5" />
                    <feComposite in2="hardAlpha" operator="out" />
                    <feColorMatrix
                      type="matrix"
                      values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.25 0"
                    />
                    <feBlend
                      mode="normal"
                      in2="BackgroundImageFix"
                      result="effect1_dropShadow_176_83"
                    />
                    <feBlend
                      mode="normal"
                      in="SourceGraphic"
                      in2="effect1_dropShadow_176_83"
                      result="shape"
                    />
                  </filter>
                </defs>
              </svg>
            )}

            {a.type === "personal" && (
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="1.875rem"
                height="1.9375rem"
                viewBox="0 0 30 31"
                fill="none"
              >
                <g filter="url(#filter0_d_176_73)">
                  <path
                    d="M15 10.5C15.663 10.5 16.2989 10.7634 16.7678 11.2322C17.2366 11.7011 17.5 12.337 17.5 13C17.5 13.663 17.2366 14.2989 16.7678 14.7678C16.2989 15.2366 15.663 15.5 15 15.5C14.337 15.5 13.7011 15.2366 13.2322 14.7678C12.7634 14.2989 12.5 13.663 12.5 13C12.5 12.337 12.7634 11.7011 13.2322 11.2322C13.7011 10.7634 14.337 10.5 15 10.5ZM15 16.75C17.7625 16.75 20 17.8688 20 19.25V20.5H10V19.25C10 17.8688 12.2375 16.75 15 16.75Z"
                    fill="white"
                    fill-opacity="0.5"
                    shape-rendering="crispEdges"
                  />
                </g>
                <defs>
                  <filter
                    id="filter0_d_176_73"
                    x="0"
                    y="0.5"
                    width="30"
                    height="30"
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
                    <feGaussianBlur stdDeviation="5" />
                    <feComposite in2="hardAlpha" operator="out" />
                    <feColorMatrix
                      type="matrix"
                      values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.25 0"
                    />
                    <feBlend
                      mode="normal"
                      in2="BackgroundImageFix"
                      result="effect1_dropShadow_176_73"
                    />
                    <feBlend
                      mode="normal"
                      in="SourceGraphic"
                      in2="effect1_dropShadow_176_73"
                      result="shape"
                    />
                  </filter>
                </defs>
              </svg>
            )}
          </div>
        )}
      </div>
      <div className="text-white/70">
        <svg
          width="2.625rem"
          height="2.625rem"
          viewBox="0 0 42 42"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <g filter="url(#filter0_d_176_75)">
            <path
              d="M26.6222 16.4595C26.6191 15.8644 26.1333 15.3787 25.5382 15.3755L17.9213 15.3351C17.3262 15.332 16.8456 15.8126 16.8487 16.4077C16.8519 17.0028 17.3376 17.4885 17.9327 17.4917L22.9527 17.5159L15.6887 24.78C15.2696 25.199 15.2732 25.8798 15.6968 26.3033C16.1203 26.7269 16.8011 26.7305 17.2202 26.3114L24.4818 19.0498L24.5108 24.0651C24.514 24.6601 24.9997 25.1459 25.5948 25.149C26.1899 25.1522 26.6705 24.6716 26.6674 24.0765L26.627 16.4595L26.6222 16.4595Z"
              fill="white"
              fill-opacity="0.55"
              shape-rendering="crispEdges"
            />
          </g>
          <defs>
            <filter
              id="filter0_d_176_75"
              x="0.376953"
              y="0.335083"
              width="41.2905"
              height="41.2883"
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
                values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.35 0"
              />
              <feBlend
                mode="normal"
                in2="BackgroundImageFix"
                result="effect1_dropShadow_176_75"
              />
              <feBlend
                mode="normal"
                in="SourceGraphic"
                in2="effect1_dropShadow_176_75"
                result="shape"
              />
            </filter>
          </defs>
        </svg>
      </div>
    </div>
  );
}

function InviteModal({
  open,
  onClose,
}: {
  open: boolean;
  onClose: () => void;
}) {
  if (!open) return null;
  return (
    <div className="absolute inset-0 flex items-center justify-center">
      <div
        className="absolute inset-0 bg-black/60 backdrop-blur-sm"
        onClick={onClose}
      />
      <div className="relative z-10 w-[26rem] bg-[#141621FA] rounded-lg p-4">
        <div className="space-y-3 max-h-64 overflow-y-auto scrollbar-hide">
          {[1, 2, 3].map((i) => (
            <div
              key={i}
              className="p-3 bg-white/3 rounded-md flex items-center gap-3 border border-white/[.08]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            >
              <img
                src="https://picsum.photos/40"
                className="w-10 h-10 rounded-full"
              />
              <div className="flex-1 text-sm">
                <div className="flex items-center justify-start gap-2 text-white text-sm font-bold">
                  Novo Convite{" "}
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width=".75rem"
                    height=".75rem"
                    viewBox="0 0 12 12"
                    fill="none"
                  >
                    <path
                      d="M7.80458 10.645C7.71598 11.0286 7.48846 11.3723 7.15997 11.6189C6.83148 11.8655 6.4219 12 5.99954 12C5.57718 12 5.16759 11.8655 4.83911 11.6189C4.51062 11.3723 4.2831 11.0286 4.1945 10.645C5.39447 10.7659 6.6046 10.7659 7.80458 10.645ZM6 1.40379e-10C6.91108 -7.40744e-06 7.79403 0.293151 8.49865 0.829606C9.20327 1.36606 9.68604 2.11268 9.86484 2.94246L10.4362 5.59685C10.5534 6.14041 10.8405 6.6394 11.2623 7.03121L11.6648 7.40502C11.8093 7.53921 11.9124 7.70687 11.9636 7.89059C12.0147 8.07432 12.012 8.26741 11.9556 8.44982C11.8993 8.63223 11.7914 8.79731 11.6432 8.92793C11.495 9.05855 11.3119 9.14994 11.1128 9.19261L9.7633 9.4824C7.28709 10.0141 4.71291 10.0141 2.2367 9.4824L0.887186 9.19261C0.688112 9.14994 0.504966 9.05855 0.356758 8.92793C0.208551 8.79731 0.100685 8.63223 0.0443585 8.44982C-0.0119678 8.26741 -0.0147015 8.07432 0.0364413 7.89059C0.087584 7.70687 0.190739 7.53921 0.335198 7.40502L0.738573 7.03035C1.16052 6.63858 1.448 6.13944 1.56471 5.59599L2.13701 2.9416C2.31593 2.11227 2.79851 1.36607 3.50274 0.829818C4.20696 0.293566 5.08937 0.000349109 6 1.40379e-10Z"
                      fill="#df5454"
                    />
                  </svg>
                </div>
                <div className="text-xs text-white/60">
                  Guilherme Costa te convidou para participar de uma conta
                  sociedade: Casal.
                </div>
              </div>
              <div className="flex flex-col gap-2">
                <button
                  className="px-3 py-1 rounded-md bg-transparent border border-white/[.05] text-xs text-white/50"
                  style={{
                    background:
                      "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                  }}
                >
                  RECUSAR
                </button>
                <button className="px-3 py-1 rounded-md bg-blue-500 text-white text-xs">
                  ACEITAR
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

export function Login() {
  const [invOpen, setInvOpen] = useState(false);
  const navigate = useNavigate();
  const userData = useUserData();
  const { jointAccounts } = useJointAccounts();

  const accounts: Account[] = [
    {
      id: "personal",
      name: userData?.name || "Usuário",
      subtitle: "Conta pessoal",
      avatar: "",
      type: "personal",
    },
    ...jointAccounts.map(account => ({
      id: account.id.toString(),
      name: account.account_name,
      subtitle: `Conta ${account.account_type}`,
      avatar: "",
      type: "joint" as const,
    })),
  ];

  function openAccount(id: string, type: string) {
    // Salvar a conta selecionada no localStorage
    localStorage.setItem('selectedAccount', JSON.stringify({ id, type }));
    
    // Navegar para a página principal do banco
    navigate("/home");
  }

  return (
    <div
      className="w-[29.5rem] h-[34.875rem] flex flex-col relative p-6"
      style={{ backgroundImage: `url(${loginBg})`, backgroundSize: "cover" }}
    >
      <img src={logo} alt="logo" className="w-16 h-16 mx-auto" />
      <h1 className="mt-4 text-center text-white text-[2rem] font-bold">
        Banco
      </h1>
      <p className="text-center mb-6 text-white/65 text-sm font-normal">
        Selecione ou crie uma conta para continuar!
      </p>

      <div className="space-y-3">
        {accounts.map((a) => (
          <AccountRow key={a.id} a={a} onOpen={(id) => openAccount(id, a.type || 'personal')} />
        ))}
      </div>

      <div className="mt-auto text-center">
        <button
          className="text-sm underline text-white/80"
          onClick={() => navigate("/register")}
        >
          Cadastrar nova{" "}
          <span className="font-semibold">conta em sociedade</span>
        </button>
      </div>

      <button
        onClick={() => setInvOpen(true)}
        aria-label="Notificações"
        className="absolute top-4 right-4 flex items-center justify-center"
        style={{ width: 40, height: 40 }}
      >
        <div className="relative">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="1.125rem"
            height="1.1875rem"
            viewBox="0 0 18 19"
            fill="none"
          >
            <path
              d="M11.7069 16.8546C11.574 17.4619 11.2327 18.0061 10.74 18.3966C10.2472 18.787 9.63284 19 8.99931 19C8.36577 19 7.75139 18.787 7.25866 18.3966C6.76593 18.0061 6.42465 17.4619 6.29175 16.8546C8.09171 17.046 9.9069 17.046 11.7069 16.8546ZM9 2.22266e-10C10.3666 -1.17284e-05 11.691 0.464155 12.748 1.31354C13.8049 2.16293 14.5291 3.34508 14.7973 4.65889L15.6543 8.86167C15.8302 9.72232 16.2608 10.5124 16.8935 11.1327L17.4972 11.7246C17.7139 11.9371 17.8686 12.2025 17.9453 12.4934C18.0221 12.7843 18.018 13.0901 17.9335 13.3789C17.849 13.6677 17.6872 13.9291 17.4649 14.1359C17.2425 14.3427 16.9678 14.4874 16.6692 14.555L14.645 15.0138C10.9306 15.8557 7.06936 15.8557 3.35504 15.0138L1.33078 14.555C1.03217 14.4874 0.757449 14.3427 0.535137 14.1359C0.312826 13.9291 0.151027 13.6677 0.0665378 13.3789C-0.0179518 13.0901 -0.0220523 12.7843 0.0546619 12.4934C0.131376 12.2025 0.286109 11.9371 0.502796 11.7246L1.10786 11.1314C1.74078 10.5111 2.17201 9.72078 2.34706 8.86032L3.20551 4.65754C3.4739 3.34443 4.19777 2.16294 5.2541 1.31388C6.31043 0.464812 7.63405 0.000552756 9 2.22266e-10Z"
              fill="white"
            />
          </svg>
          <span className="absolute -top-2 -right-2 inline-flex items-center justify-center bg-red-500 text-white text-[10px] font-semibold rounded-full w-4 h-4">
            2
          </span>
        </div>
      </button>

      <InviteModal open={invOpen} onClose={() => setInvOpen(false)} />
    </div>
  );
}
