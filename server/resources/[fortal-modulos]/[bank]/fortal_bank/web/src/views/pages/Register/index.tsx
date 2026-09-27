import { useState, useRef, useEffect } from "react";
import * as motion from "motion/react-client";
import loginBg from "@views/assets/loginBg.png";
import logo from "@views/assets/logo.png";
import { useNavigate } from "react-router-dom";
import { useJointAccounts } from "../../../hooks/useJointAccounts";
import { fetchNui } from "../../../app/utils/fetchNui";

function CustomSelect({
  options,
  value,
  onChange,
}: {
  options: string[];
  value: string;
  onChange: (v: string) => void;
}) {
  const [open, setOpen] = useState(false);
  const root = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    function onDoc(e: MouseEvent) {
      if (!root.current) return;
      if (!root.current.contains(e.target as Node)) setOpen(false);
    }
    document.addEventListener("mousedown", onDoc);
    return () => document.removeEventListener("mousedown", onDoc);
  }, []);

  return (
    <div ref={root} className="relative">
      <button
        type="button"
        onClick={() => setOpen((s) => !s)}
        className="w-full text-left pr-10"
        style={{
          padding: "0.75rem",
          borderRadius: "0.375rem",
          border: "1px solid rgba(255,255,255,0.03)",
          background:
            "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
          color: "#FFF",
          fontSize: "0.875rem",
          fontWeight: 500,
        }}
      >
        <span>{value}</span>
        <span className="absolute inset-y-0 right-3 flex items-center pointer-events-none">
          <svg
            width="1rem"
            height=".625rem"
            viewBox="0 0 16 10"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M1 1L8 8L15 1"
              stroke="white"
              strokeOpacity="0.9"
              strokeWidth="1.5"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
          </svg>
        </span>
      </button>

      {open && (
        <div
          className="absolute w-full rounded-md overflow-hidden z-20"
          style={{ boxShadow: "0 6px 18px rgba(0,0,0,0.6)" }}
        >
          <div style={{ background: "#0E111C" }} className="py-1">
            {options.map((o) => (
              <button
                key={o}
                type="button"
                onClick={() => {
                  onChange(o);
                  setOpen(false);
                }}
                className="w-full text-left px-4 py-2 hover:bg-white/5"
                style={{ color: "#FFF", fontSize: "0.875rem", fontWeight: 500 }}
              >
                {o}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

export function Register() {
  const [step, setStep] = useState(0);
  const [type, setType] = useState("Casal");
  const [participants, setParticipants] = useState<string[]>(["Eu"]);
  const [newParticipantId, setNewParticipantId] = useState("");
  const [pin, setPin] = useState(["", "", "", ""]);
  const [nickname, setNickname] = useState("");
  const [imageUrl, setImageUrl] = useState("");
  const [showAdd, setShowAdd] = useState(false);
  const maxParticipants = 2;

  const navigate = useNavigate();
  const { createJointAccount } = useJointAccounts();

  function next() {
    if (step < 2) setStep(step + 1);
  }
  function back() {
    if (step > 0) setStep(step - 1);
    else navigate(-1);
  }

  function addParticipant(id: string) {
    if (!id) return;
    if (participants.length >= maxParticipants) {
      console.warn("Máximo de participantes atingido");
      return;
    }
    setParticipants((p) => [...p, id]);
    setNewParticipantId("");
    setShowAdd(false);
  }

  function removeParticipant(id: string) {
    if (id === "Eu") return;
    setParticipants((p) => p.filter((x) => x !== id));
  }

  function setPinAt(index: number, val: string, inputRef?: HTMLInputElement) {
    const v = val.replace(/[^0-9]/g, "").slice(0, 1);
    setPin((p) => {
      const cp = [...p];
      cp[index] = v;
      return cp;
    });

    // Navegação automática para o próximo campo
    if (v && index < 3) {
      // Se digitou um número e não é o último campo, vai para o próximo
      setTimeout(() => {
        const nextInput = document.querySelector(`input[data-pin-index="${index + 1}"]`) as HTMLInputElement;
        if (nextInput) {
          nextInput.focus();
        }
      }, 10);
    }
  }

  function handlePinKeyDown(index: number, e: React.KeyboardEvent<HTMLInputElement>) {
    if (e.key === 'Backspace' && !pin[index] && index > 0) {
      // Se pressionou backspace em campo vazio, vai para o anterior
      const prevInput = document.querySelector(`input[data-pin-index="${index - 1}"]`) as HTMLInputElement;
      if (prevInput) {
        prevInput.focus();
      }
    }
  }

  async function confirm() {
    console.log("CONFIRMAR clicado - Iniciando validação...");
    
    // Validações finais
    if (!nickname.trim()) {
      console.log("Erro: Apelido vazio");
      // Enviar notificação para o jogo
      fetchNui('showNotification', {
        type: 'error',
        message: 'Por favor, informe um apelido para a conta.'
      });
      return;
    }

    const pinString = pin.join("");
    if (pinString.length !== 4) {
      // Enviar notificação para o jogo
      fetchNui('showNotification', {
        type: 'error',
        message: 'Por favor, informe um PIN de 4 dígitos.'
      });
      return;
    }

    try {
      const payload = {
        account_name: nickname.trim(),
        account_type: type.toLowerCase() as "casal" | "familia" | "empresarial" | "conjunto",
        participants: participants.filter(p => p !== "Eu").map(p => parseInt(p)).filter(id => !isNaN(id)),
      };

      console.log("Criando conta em sociedade:", payload);

      const result = await createJointAccount(payload);
      
      if (result.success) {
        console.log("Conta criada com sucesso:", result.account_id);
        // Enviar notificação de sucesso para o jogo
        fetchNui('showNotification', {
          type: 'success',
          message: 'Conta criada com sucesso!'
        });
        navigate("/login");
      } else {
        console.error("Erro ao criar conta:", result.message);
        // Enviar notificação de erro para o jogo
        fetchNui('showNotification', {
          type: 'error',
          message: result.message || 'Erro ao criar conta.'
        });
      }
    } catch (error) {
      console.error("Erro ao criar conta:", error);
      // Enviar notificação de erro para o jogo
      fetchNui('showNotification', {
        type: 'error',
        message: 'Erro no servidor. Tente novamente.'
      });
    }
  }

  return (
    <motion.div
      initial={{ opacity: 0, scale: 0 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{
        duration: 0.4,
        scale: { type: "spring", visualDuration: 0.4, bounce: 0.2 },
      }}
      className="w-[29.5rem] h-[34.875rem] flex flex-col relative p-6"
      style={{ backgroundImage: `url(${loginBg})`, backgroundSize: "cover" }}
    >
      <button className="mb-4 text-sm text-white/60" onClick={back}>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="2.875rem"
          height="2.75rem"
          viewBox="0 0 46 44"
          fill="none"
        >
          <g filter="url(#filter0_d_176_301)">
            <path
              d="M15.8139 21.2352C15.3954 21.6582 15.3954 22.3452 15.8139 22.7682L21.1714 28.1827C21.5899 28.6058 22.2696 28.6058 22.6882 28.1827C23.1067 27.7597 23.1067 27.0728 22.6882 26.6497L19.1556 23.0829L29.4285 23.0829C30.0212 23.0829 30.5 22.599 30.5 22C30.5 21.401 30.0212 20.9171 29.4285 20.9171L19.159 20.9171L22.6848 17.3503C23.1034 16.9272 23.1034 16.2403 22.6848 15.8173C22.2663 15.3942 21.5866 15.3942 21.168 15.8173L15.8106 21.2318L15.8139 21.2352Z"
              fill="white"
              fill-opacity="0.55"
              shape-rendering="crispEdges"
            />
          </g>
          <defs>
            <filter
              id="filter0_d_176_301"
              x="0.5"
              y="0.5"
              width="45"
              height="43"
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
                result="effect1_dropShadow_176_301"
              />
              <feBlend
                mode="normal"
                in="SourceGraphic"
                in2="effect1_dropShadow_176_301"
                result="shape"
              />
            </filter>
          </defs>
        </svg>
      </button>
      <div className="flex flex-col items-center">
        <img src={logo} alt="logo" className="w-16 h-16" />
        <h2 className="mt-4 text-center text-white text-[2rem] font-bold">
          Banco
        </h2>
        <p className="text-center mb-6 text-white/65 text-sm font-normal">
          Cadastro de conta.
        </p>

        {step === 0 && (
          <div className="w-full space-y-4">
            <div>
              <label className="text-sm text-white/70 block mb-2">
                Tipo de conta em sociedade
              </label>
              <CustomSelect
                options={["Casal", "Empresarial", "Família", "Conjunto"]}
                value={type}
                onChange={(v) => setType(v)}
              />
            </div>

            <div>
              <div className="flex items-center justify-between mb-2">
                <label className="text-sm text-white/70">
                  Participantes da conta
                </label>
                <div className="text-sm text-white/60">
                  {participants.length}/{maxParticipants}
                </div>
              </div>
              <div className="flex gap-2 items-center">
                <div
                  className="flex-1 px-3 py-[.53rem] rounded-md"
                  style={{
                    borderRadius: "0.375rem",
                    border: "1px solid rgba(255,255,255,0.03)",
                    background:
                      "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255,255,255,0.02) 0%, rgba(255,255,255,0.00) 100%), linear-gradient(91deg, rgba(255,255,255,0.01) 0%, rgba(255,255,255,0.01) 100%)",
                    minHeight: 44,
                  }}
                >
                  <div className="flex flex-wrap gap-2 items-center">
                    {participants.map((p) => (
                      <div
                        key={p}
                        className="flex items-center gap-2 px-3 py-1 bg-white/10 rounded-[.3125rem]"
                        style={{ color: "#FFF", fontSize: "0.875rem" }}
                      >
                        {p === "Eu" ? (
                          <>
                            <span>{p}</span>
                          </>
                        ) : (
                          <>
                            <span>{p}</span>
                            <button
                              onClick={() => removeParticipant(p)}
                              className="ml-2 text-white/60"
                            >
                              ✕
                            </button>
                          </>
                        )}
                      </div>
                    ))}
                  </div>
                </div>
                <button
                  className="px-4 py-2 bg-transparent border border-white/10 rounded-md text-white"
                  onClick={() => setShowAdd(true)}
                  aria-label="Adicionar participante"
                >
                  +
                </button>
              </div>
            </div>

            <div className="mt-4">
              <button
                className="w-full py-3 rounded-md bg-blue-500 text-white"
                onClick={next}
              >
                PRÓXIMO
              </button>
            </div>
          </div>
        )}

        {step === 1 && (
          <div className="w-full text-center space-y-6">
            <div>
              <div className="text-sm font-semibold text-white">
                Definir PIN
              </div>
              <div className="text-xs text-white/60">
                Defina um PIN para liberar o acesso da sua conta.
              </div>
            </div>
            <div className="flex justify-center gap-3">
              {pin.map((p, i) => (
                <input
                  key={i}
                  data-pin-index={i}
                  value={p}
                  onChange={(e) => setPinAt(i, e.target.value)}
                  onKeyDown={(e) => handlePinKeyDown(i, e)}
                  className="w-14 h-14 bg-transparent border border-white/10 rounded-md text-center text-xl text-white focus:border-[#df5454] focus:outline-none transition-colors"
                  maxLength={1}
                />
              ))}
            </div>
            <div>
              <button
                className="w-full py-3 rounded-md bg-blue-500 text-white"
                onClick={next}
              >
                PRÓXIMO
              </button>
            </div>
          </div>
        )}

        {step === 2 && (
          <div className="w-full space-y-4">
            <div>
              <div className="flex items-center justify-center text-sm font-semibold text-white">
                Personalizar conta
              </div>
              <div className="flex items-center justify-center text-xs text-white/60 mb-3">
                Personalize dados, preferências e identidade da sua conta.
              </div>

              <input
                placeholder="Apelido (ex: Familia Black) *"
                value={nickname}
                onChange={(e) => setNickname(e.target.value)}
                className="w-full p-3 border border-white/[.03] rounded-md mb-3 outline-none text-white placeholder-white/40"
                style={{
                  background:
                    "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                }}
                required
              />

              <div className="flex items-center gap-3">
                <input
                  placeholder="URL da imagem (opcional)"
                  value={imageUrl}
                  onChange={(e) => setImageUrl(e.target.value)}
                  className="w-full p-3 border border-white/[.03] rounded-md mb-3 outline-none text-white placeholder-white/40"
                  style={{
                    background:
                      "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
                  }}
                />
              </div>
            </div>
            <div>
              <button
                className="w-full py-3 rounded-md bg-blue-500 text-white"
                onClick={confirm}
              >
                CONFIRMAR
              </button>
            </div>
          </div>
        )}
      </div>

      {showAdd && (
        <div className="absolute inset-0 flex items-center justify-center">
          <div
            className="absolute inset-0 bg-black/60"
            onClick={() => setShowAdd(false)}
          />

          <div className="relative z-10 w-[28rem] bg-[#141621E5] border border-white/[.05] rounded-md p-6">
            <div className="flex items-center justify-start gap-3 mb-3 text-white text-base font-bold">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="2.375rem"
                height="2.375rem"
                viewBox="0 0 38 38"
                fill="none"
              >
                <g filter="url(#filter0_d_176_347)">
                  <path
                    d="M18.0606 13.3743H20.8788L23.9693 10.2776C24.0566 10.1896 24.1605 10.1198 24.275 10.0722C24.3895 10.0245 24.5123 10 24.6363 10C24.7603 10 24.8831 10.0245 24.9975 10.0722C25.112 10.1198 25.2159 10.1896 25.3032 10.2776L27.7268 12.708C27.9018 12.8839 28 13.1217 28 13.3696C28 13.6175 27.9018 13.8554 27.7268 14.0312L25.5757 16.1895H18.0606V18.0663C18.0606 18.3152 17.9616 18.5539 17.7855 18.7298C17.6093 18.9058 17.3704 19.0047 17.1212 19.0047C16.8721 19.0047 16.6332 18.9058 16.457 18.7298C16.2808 18.5539 16.1819 18.3152 16.1819 18.0663V15.2511C16.1819 14.7533 16.3798 14.276 16.7321 13.924C17.0845 13.572 17.5623 13.3743 18.0606 13.3743ZM12.4243 18.0663V21.8199L10.2732 23.9688C10.0982 24.1446 10 24.3825 10 24.6304C10 24.8783 10.0982 25.1161 10.2732 25.292L12.6968 27.7224C12.7841 27.8104 12.888 27.8802 13.0025 27.9278C13.1169 27.9755 13.2397 28 13.3637 28C13.4877 28 13.6105 27.9755 13.725 27.9278C13.8395 27.8802 13.9434 27.8104 14.0307 27.7224L18.0606 23.6967H21.8181C22.0673 23.6967 22.3062 23.5978 22.4824 23.4218C22.6585 23.2459 22.7575 23.0072 22.7575 22.7583V21.8199H23.6969C23.946 21.8199 24.185 21.721 24.3611 21.545C24.5373 21.3691 24.6363 21.1304 24.6363 20.8815V19.9431H25.5757C25.8248 19.9431 26.0637 19.8442 26.2399 19.6682C26.4161 19.4923 26.515 19.2536 26.515 19.0047V18.0663H19.9394V19.0047C19.9394 19.5024 19.7414 19.9798 19.3891 20.3318C19.0368 20.6838 18.5589 20.8815 18.0606 20.8815H16.1819C15.6836 20.8815 15.2057 20.6838 14.8534 20.3318C14.501 19.9798 14.3031 19.5024 14.3031 19.0047V16.1895L12.4243 18.0663Z"
                    fill="white"
                    fill-opacity="0.65"
                    shape-rendering="crispEdges"
                  />
                </g>
                <defs>
                  <filter
                    id="filter0_d_176_347"
                    x="0"
                    y="0"
                    width="38"
                    height="38"
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
                      result="effect1_dropShadow_176_347"
                    />
                    <feBlend
                      mode="normal"
                      in="SourceGraphic"
                      in2="effect1_dropShadow_176_347"
                      result="shape"
                    />
                  </filter>
                </defs>
              </svg>
              Adicionar participante
            </div>
            <div className="text-xs text-white/60 mb-3">ID do participante</div>

            <input
              placeholder="EX: 123"
              value={newParticipantId}
              onChange={(e) => setNewParticipantId(e.target.value)}
              className="w-full p-3 bg-white/2 rounded-md mb-4 border border-white/[.03] outline-none text-white"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            />
            <div className="flex gap-3">
              <button
                className="flex-1 py-2 rounded-md bg-transparent border border-white/10 text-white/65"
                onClick={() => {
                  setShowAdd(false);
                  setNewParticipantId("");
                }}
              >
                CANCELAR
              </button>
              <button
                className="flex-1 py-2 rounded-md bg-blue-500 text-white"
                onClick={() => addParticipant(newParticipantId)}
              >
                CONFIRMAR
              </button>
            </div>
          </div>
        </div>
      )}
    </motion.div>
  );
}
