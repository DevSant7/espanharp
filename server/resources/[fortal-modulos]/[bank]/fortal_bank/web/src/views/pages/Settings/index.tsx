import * as motion from "motion/react-client";
import { Separator } from "@views/components/ui/separator";
import { Settings, Camera, User, Shield, Check } from "lucide-react";
import { useUserData } from "../../../hooks/useUserData";
import { useAccountInfo } from "../../../hooks/useAccountInfo";
import { useSelectedAccount } from "../../../hooks/useSelectedAccount";
import { useJointAccounts } from "../../../hooks/useJointAccounts";
import { UserAvatar } from "@views/components/UserAvatar";
import { useState, useEffect } from "react";

export function SettingsPage() {
  const userData = useUserData();
  const { accountInfo, loading, updateAccountInfo, resetSecurityPin } = useAccountInfo();
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();
  const { jointAccounts } = useJointAccounts();
  const [activeTab, setActiveTab] = useState<"info" | "security">("info");
  const [isUpdating, setIsUpdating] = useState<boolean>(false);
  const [showCurrentPin, setShowCurrentPin] = useState<boolean>(false);
  const [showRepeatPin, setShowRepeatPin] = useState<boolean>(false);
  const [showNewPin, setShowNewPin] = useState<boolean>(false);
  const [pinData, setPinData] = useState({
    currentPin: "",
    repeatPin: "",
    newPin: ""
  });
  const [isResettingPin, setIsResettingPin] = useState<boolean>(false);
  const [profileData, setProfileData] = useState({
    firstName: "",
    lastName: "",
    username: "",
    keyType: "usuario" as "usuario" | "passaporte" | "registro",
    gender: "masculino" as "masculino" | "feminino",
    profileImageUrl: "",
  });

  // Determinar dados da conta atual
  const currentAccountData = (() => {
    if (isPersonalAccount) {
      return {
        name: accountInfo?.full_name || userData?.name || "Usuário",
        type: "Conta pessoal"
      };
    } else if (isJointAccount && selectedAccount) {
      const jointAccount = jointAccounts.find(acc => acc.id.toString() === selectedAccount.id);
      return {
        name: jointAccount?.account_name || "Conta conjunta",
        type: `Conta ${jointAccount?.account_type || 'conjunta'}`
      };
    }
    return {
      name: accountInfo?.full_name || userData?.name || "Usuário",
      type: "Conta pessoal"
    };
  })();

  // Atualizar dados do perfil quando accountInfo mudar
  useEffect(() => {
    if (accountInfo) {
      const nameParts = accountInfo.full_name.split(" ");
      setProfileData({
        firstName: nameParts[0] || "",
        lastName: nameParts.slice(1).join(" ") || "",
        username: accountInfo.username || "",
        keyType: accountInfo.transfer_key_type || "usuario",
        gender: accountInfo.gender || "masculino",
        profileImageUrl: accountInfo.profile_photo || "",
      });
    }
  }, [accountInfo]);

  const handleUpdateProfile = async () => {
    setIsUpdating(true);

    try {
      const fullName = `${profileData.firstName} ${profileData.lastName}`.trim();
      
      const updateData = {
        full_name: fullName,
        nickname: profileData.lastName,
        username: profileData.username,
        gender: profileData.gender,
        transfer_key_type: profileData.keyType,
        profile_photo: profileData.profileImageUrl
      };

      console.log("Atualizando perfil:", updateData);
      
      const success = await updateAccountInfo(updateData);
      
      if (success) {
        console.log("Perfil atualizado com sucesso!");
        // Aqui você pode adicionar uma notificação de sucesso
      } else {
        console.error("Falha ao atualizar perfil");
        // Aqui você pode adicionar uma notificação de erro
      }
    } catch (error) {
      console.error("Erro ao atualizar perfil:", error);
    } finally {
      setIsUpdating(false);
    }
  };

  const handleInputChange = (
    field: keyof typeof profileData,
    value: string
  ) => {
    setProfileData((prev) => ({
      ...prev,
      [field]: value,
    }));
  };

  const handlePhotoUpload = async () => {
    if (!profileData.profileImageUrl || profileData.profileImageUrl.trim() === "") {
      console.log("URL da foto não informada");
      return;
    }

    setIsUpdating(true);

    try {
      const success = await updateAccountInfo({
        profile_photo: profileData.profileImageUrl.trim()
      });
      
      if (success) {
        console.log("Foto de perfil atualizada com sucesso!");
        // Aqui você pode adicionar uma notificação de sucesso
      } else {
        console.error("Falha ao atualizar foto de perfil");
        // Aqui você pode adicionar uma notificação de erro
      }
    } catch (error) {
      console.error("Erro ao atualizar foto de perfil:", error);
    } finally {
      setIsUpdating(false);
    }
  };

  const handlePinChange = (field: keyof typeof pinData, value: string) => {
    setPinData(prev => ({
      ...prev,
      [field]: value.replace(/\D/g, '').slice(0, 4) // Apenas números e máximo 4 dígitos
    }));
  };

  const handleResetPin = async () => {
    setIsResettingPin(true);
    
    try {
      const success = await resetSecurityPin();
      
      if (success) {
        console.log("PIN resetado para 0000 com sucesso!");
        setPinData({
          currentPin: "0000",
          repeatPin: "",
          newPin: ""
        });
        // Aqui você pode adicionar uma notificação de sucesso
      } else {
        console.error("Falha ao resetar PIN");
        // Aqui você pode adicionar uma notificação de erro
      }
    } catch (error) {
      console.error("Erro ao resetar PIN:", error);
    } finally {
      setIsResettingPin(false);
    }
  };

  const handleUpdatePin = async () => {
    if (pinData.newPin.length !== 4) {
      console.error("Novo PIN deve ter 4 dígitos");
      return;
    }

    if (pinData.currentPin !== accountInfo?.security_pin) {
      console.error("PIN atual incorreto");
      return;
    }

    if (pinData.newPin !== pinData.repeatPin) {
      console.error("Novo PIN e repetição não coincidem");
      return;
    }

    setIsUpdating(true);

    try {
      const success = await updateAccountInfo({
        security_pin: pinData.newPin
      });
      
      if (success) {
        console.log("PIN atualizado com sucesso!");
        setPinData({
          currentPin: "",
          repeatPin: "",
          newPin: ""
        });
        // Aqui você pode adicionar uma notificação de sucesso
      } else {
        console.error("Falha ao atualizar PIN");
        // Aqui você pode adicionar uma notificação de erro
      }
    } catch (error) {
      console.error("Erro ao atualizar PIN:", error);
    } finally {
      setIsUpdating(false);
    }
  };

  return (
    <>
      <motion.div
        initial={{ opacity: 0, scale: 0 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{
          duration: 0.4,
          scale: { type: "spring", visualDuration: 0.4, bounce: 0.2 },
        }}
        className="w-[74rem] flex flex-col"
      >
        <div className="w-full h-[6rem] flex items-center justify-between p-6">
          <div className="flex items-center justify-center gap-4">
            <svg
              width="1.5rem"
              height="1.5rem"
              viewBox="0 0 24 24"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect
                width="24"
                height="24"
                rx="3"
                fill="#df5454"
                fill-opacity="0.08"
              />
              <path
                d="M12 5C12.7064 5 13.3969 5.20527 13.9842 5.58986C14.5715 5.97444 15.0293 6.52107 15.2996 7.16061C15.5699 7.80015 15.6406 8.50388 15.5028 9.18282C15.365 9.86175 15.0249 10.4854 14.5254 10.9749C14.0259 11.4644 13.3895 11.7977 12.6968 11.9327C12.004 12.0678 11.2859 11.9985 10.6333 11.7336C9.98068 11.4687 9.4229 11.0201 9.03047 10.4445C8.63803 9.86892 8.42857 9.19223 8.42857 8.5L8.43214 8.3481C8.47209 7.44703 8.86543 6.59584 9.53016 5.97206C10.1949 5.34828 11.0797 5.00005 12 5ZM13.4286 13.4C14.3758 13.4 15.2842 13.7687 15.954 14.4251C16.6237 15.0815 17 15.9717 17 16.9V17.6C17 17.9713 16.8495 18.3274 16.5816 18.5899C16.3137 18.8525 15.9503 19 15.5714 19H8.42857C8.04969 19 7.68633 18.8525 7.41842 18.5899C7.15051 18.3274 7 17.9713 7 17.6V16.9C7 15.9717 7.37627 15.0815 8.04605 14.4251C8.71582 13.7687 9.62423 13.4 10.5714 13.4H13.4286Z"
                fill="#df5454"
              />
            </svg>

            <div className="flex items-center justify-center gap-2">
              <h1 className="text-white text-base font-bold">Configurações</h1>
              <span className="text-white/45 text-xs font-normal">/ Banco</span>
            </div>
          </div>

          <div className="flex items-center gap-6">
            <div className="text-right">
              <div className="text-white text-sm">
                {currentAccountData.name}
              </div>
              <div className="flex items-center justify-end gap-[.38rem]">
                <span className="text-white/55 text-[.6875rem]">
                  {currentAccountData.type}
                </span>
              </div>
            </div>

            <UserAvatar size="md" />
          </div>
        </div>

        <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF08]" />

        <div className="flex flex-col items-center justify-center gap-6 p-6">
          <div
            className="w-[72rem] rounded-md p-8"
            style={{
              background:
                "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
            }}
          >
            <div className="flex items-center gap-2 mb-[1.31rem]">
              <button
                onClick={() => setActiveTab("info")}
                className={`flex items-center justify-center w-[6.8125rem] h-8 rounded-[0.25rem] px-[.75rem] text-xs font-bold transition-all ${
                  activeTab === "info"
                    ? "bg-[#df5454] text-white"
                    : "bg-white/[0.05] text-white/60 hover:text-white/80"
                }`}
              >
                INFORMAÇÕES
              </button>
              <button
                onClick={() => setActiveTab("security")}
                className={`flex items-center justify-center w-[6.8125rem] h-8 rounded-[0.25rem] px-[.75rem] text-xs font-bold transition-all ${
                  activeTab === "security"
                    ? "bg-[#df5454] text-white"
                    : "bg-white/[0.05] text-white/60 hover:text-white/80"
                }`}
              >
                SEGURANÇA
              </button>
            </div>

            {activeTab === "info" && (
              <div className="space-y-6">
                <div className="space-y-4">
                  <div className="flex items-center justify-start gap-2 text-white/60 text-sm font-medium">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width=".4375rem"
                      height=".625rem"
                      viewBox="0 0 7 10"
                      fill="none"
                    >
                      <path
                        d="M3.5 0C3.99445 0 4.4778 0.146622 4.88893 0.421326C5.30005 0.696029 5.62048 1.08648 5.8097 1.54329C5.99892 2.00011 6.04843 2.50277 5.95196 2.98773C5.8555 3.47268 5.6174 3.91814 5.26777 4.26777C4.91814 4.6174 4.47268 4.8555 3.98773 4.95196C3.50277 5.04843 3.00011 4.99892 2.54329 4.8097C2.08648 4.62048 1.69603 4.30005 1.42133 3.88893C1.14662 3.4778 1 2.99445 1 2.5L1.0025 2.3915C1.03046 1.74788 1.3058 1.13989 1.77111 0.69433C2.23642 0.248771 2.85577 3.72212e-05 3.5 0ZM4.5 6C5.16304 6 5.79893 6.26339 6.26777 6.73223C6.73661 7.20107 7 7.83696 7 8.5V9C7 9.26522 6.89464 9.51957 6.70711 9.70711C6.51957 9.89464 6.26522 10 6 10H1C0.734784 10 0.48043 9.89464 0.292893 9.70711C0.105357 9.51957 0 9.26522 0 9V8.5C0 7.83696 0.263392 7.20107 0.732233 6.73223C1.20107 6.26339 1.83696 6 2.5 6H4.5Z"
                        fill="white"
                        fill-opacity="0.25"
                      />
                    </svg>{" "}
                    Sua foto de perfil
                  </div>

                  <div className="w-[69rem] h-[6rem] rounded-[0.25rem] border border-white/[.06] bg-white/[.02] flex items-center gap-4 px-4 py-5">
                    <div className="w-16 h-16 rounded-full overflow-hidden border border-white/20">
                      {profileData.profileImageUrl ? (
                        <img
                          src={profileData.profileImageUrl}
                          alt="Profile"
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <div className="w-full h-full bg-[#df5454] flex items-center justify-center">
                          <User className="w-8 h-8 text-white" />
                        </div>
                      )}
                    </div>

                    <div className="flex-1">
                      <input
                        type="text"
                        value={profileData.profileImageUrl}
                        onChange={(e) =>
                          handleInputChange("profileImageUrl", e.target.value)
                        }
                        placeholder="WWW.IMGUR.COM/EXAMPLE"
                        className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors text-sm"
                      />
                    </div>

                    <button
                      onClick={handlePhotoUpload}
                      disabled={isUpdating}
                      className="px-4 py-2 bg-[#df5454] hover:bg-[#2E6FB8] disabled:opacity-50 disabled:cursor-not-allowed text-white text-sm font-medium rounded-md transition-colors"
                    >
                      {isUpdating ? "ENVIANDO..." : "ENVIAR NOVA FOTO"}
                    </button>
                  </div>
                </div>

                <Separator className="w-full h-[0.0625rem] bg-white/[.05]" />

                <div className="flex items-center justify-start gap-2 text-white/60 text-sm font-medium mb-4">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width=".4375rem"
                    height=".625rem"
                    viewBox="0 0 7 10"
                    fill="none"
                  >
                    <path
                      d="M3.5 0C3.99445 0 4.4778 0.146622 4.88893 0.421326C5.30005 0.696029 5.62048 1.08648 5.8097 1.54329C5.99892 2.00011 6.04843 2.50277 5.95196 2.98773C5.8555 3.47268 5.6174 3.91814 5.26777 4.26777C4.91814 4.6174 4.47268 4.8555 3.98773 4.95196C3.50277 5.04843 3.00011 4.99892 2.54329 4.8097C2.08648 4.62048 1.69603 4.30005 1.42133 3.88893C1.14662 3.4778 1 2.99445 1 2.5L1.0025 2.3915C1.03046 1.74788 1.3058 1.13989 1.77111 0.69433C2.23642 0.248771 2.85577 3.72212e-05 3.5 0ZM4.5 6C5.16304 6 5.79893 6.26339 6.26777 6.73223C6.73661 7.20107 7 7.83696 7 8.5V9C7 9.26522 6.89464 9.51957 6.70711 9.70711C6.51957 9.89464 6.26522 10 6 10H1C0.734784 10 0.48043 9.89464 0.292893 9.70711C0.105357 9.51957 0 9.26522 0 9V8.5C0 7.83696 0.263392 7.20107 0.732233 6.73223C1.20107 6.26339 1.83696 6 2.5 6H4.5Z"
                      fill="white"
                      fill-opacity="0.25"
                    />
                  </svg>{" "}
                  Informações
                </div>

                <div className="space-y-4">
                  <div className="space-y-2">
                    <label className="text-white/60 text-sm font-medium block">
                      Gênero
                    </label>
                    <div className="flex items-center gap-4">
                      <div className="flex items-center gap-2">
                        <div className="relative">
                          <button
                            type="button"
                            onClick={() =>
                              handleInputChange("gender", "masculino")
                            }
                            className={`flex items-center justify-center w-5 h-5 border rounded cursor-pointer transition-colors ${
                              profileData.gender === "masculino"
                                ? "bg-[#df5454] border-[#df5454]"
                                : "bg-white/[0.05] border-white/[0.2] hover:border-white/[0.4]"
                            }`}
                          >
                            {profileData.gender === "masculino" && (
                              <svg
                                className="w-3 h-3 text-white"
                                fill="currentColor"
                                viewBox="0 0 20 20"
                              >
                                <path
                                  fillRule="evenodd"
                                  d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                  clipRule="evenodd"
                                ></path>
                              </svg>
                            )}
                          </button>
                        </div>
                        <label
                          onClick={() =>
                            handleInputChange("gender", "masculino")
                          }
                          className="text-white/80 text-sm cursor-pointer"
                        >
                          Masculino
                        </label>
                      </div>
                      <div className="flex items-center gap-2">
                        <div className="relative">
                          <button
                            type="button"
                            onClick={() =>
                              handleInputChange("gender", "feminino")
                            }
                            className={`flex items-center justify-center w-5 h-5 border rounded cursor-pointer transition-colors ${
                              profileData.gender === "feminino"
                                ? "bg-[#df5454] border-[#df5454]"
                                : "bg-white/[0.05] border-white/[0.2] hover:border-white/[0.4]"
                            }`}
                          >
                            {profileData.gender === "feminino" && (
                              <svg
                                className="w-3 h-3 text-white"
                                fill="currentColor"
                                viewBox="0 0 20 20"
                              >
                                <path
                                  fillRule="evenodd"
                                  d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                  clipRule="evenodd"
                                ></path>
                              </svg>
                            )}
                          </button>
                        </div>
                        <label
                          onClick={() =>
                            handleInputChange("gender", "feminino")
                          }
                          className="text-white/80 text-sm cursor-pointer"
                        >
                          Feminino
                        </label>
                      </div>
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="text-white/60 text-sm font-medium mb-2 block">
                        Nome completo
                      </label>
                      <input
                        type="text"
                        value={profileData.firstName}
                        onChange={(e) =>
                          handleInputChange("firstName", e.target.value)
                        }
                        className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors"
                      />
                    </div>
                    <div>
                      <label className="text-white/60 text-sm font-medium mb-2 block">
                        Apelido
                      </label>
                      <input
                        type="text"
                        value={profileData.lastName}
                        onChange={(e) =>
                          handleInputChange("lastName", e.target.value)
                        }
                        className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors"
                      />
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-4 items-end">
                    <div>
                      <label className="text-white/60 text-sm font-medium mb-2 block">
                        Usuário
                      </label>
                      <div className="relative">
                        <User className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-white/40" />
                        <input
                          type="text"
                          value={profileData.username}
                          onChange={(e) =>
                            handleInputChange("username", e.target.value)
                          }
                          className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md pl-10 pr-4 py-3 text-white placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors"
                        />
                      </div>
                    </div>

                    <div>
                      <label className="text-white/60 text-sm font-medium mb-2 block">
                        Tipo de chave de transferência
                      </label>
                      <div className="flex items-center gap-4">
                        {[
                          { key: "usuario", label: "Usuário" },
                          { key: "passaporte", label: "Passaporte" },
                          { key: "registro", label: "Registro" },
                        ].map((option) => (
                          <div
                            key={option.key}
                            className="flex items-center gap-2"
                          >
                            <div className="relative">
                              <button
                                type="button"
                                onClick={() =>
                                  handleInputChange("keyType", option.key)
                                }
                                className={`flex items-center justify-center w-5 h-5 border rounded cursor-pointer transition-colors ${
                                  profileData.keyType === option.key
                                    ? "bg-[#df5454] border-[#df5454]"
                                    : "bg-white/[0.05] border-white/[0.2] hover:border-white/[0.4]"
                                }`}
                              >
                                {profileData.keyType === option.key && (
                                  <svg
                                    className="w-3 h-3 text-white"
                                    fill="currentColor"
                                    viewBox="0 0 20 20"
                                  >
                                    <path
                                      fillRule="evenodd"
                                      d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                      clipRule="evenodd"
                                    ></path>
                                  </svg>
                                )}
                              </button>
                            </div>
                            <label
                              onClick={() =>
                                handleInputChange("keyType", option.key)
                              }
                              className="text-white/80 text-sm cursor-pointer"
                            >
                              {option.label}
                            </label>
                          </div>
                        ))}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {activeTab === "security" && (
              <div className="space-y-6">
                <div className="flex items-center justify-center gap-2 text-white/60 text-sm font-medium mb-4">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width=".4375rem"
                    height=".625rem"
                    viewBox="0 0 7 10"
                    fill="none"
                  >
                    <path
                      d="M3.5 0C3.99445 0 4.4778 0.146622 4.88893 0.421326C5.30005 0.696029 5.62048 1.08648 5.8097 1.54329C5.99892 2.00011 6.04843 2.50277 5.95196 2.98773C5.8555 3.47268 5.6174 3.91814 5.26777 4.26777C4.91814 4.6174 4.47268 4.8555 3.98773 4.95196C3.50277 5.04843 3.00011 4.99892 2.54329 4.8097C2.08648 4.62048 1.69603 4.30005 1.42133 3.88893C1.14662 3.4778 1 2.99445 1 2.5L1.0025 2.3915C1.03046 1.74788 1.3058 1.13989 1.77111 0.69433C2.23642 0.248771 2.85577 3.72212e-05 3.5 0ZM4.5 6C5.16304 6 5.79893 6.26339 6.26777 6.73223C6.73661 7.20107 7 7.83696 7 8.5V9C7 9.26522 6.89464 9.51957 6.70711 9.70711C6.51957 9.89464 6.26522 10 6 10H1C0.734784 10 0.48043 9.89464 0.292893 9.70711C0.105357 9.51957 0 9.26522 0 9V8.5C0 7.83696 0.263392 7.20107 0.732233 6.73223C1.20107 6.26339 1.83696 6 2.5 6H4.5Z"
                      fill="white"
                      fill-opacity="0.25"
                    />
                  </svg>{" "}
                  Redefinir PIN
                </div>

                <div className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="text-white/60 text-sm font-medium mb-2 block">
                        PIN atual
                      </label>
                      <div className="relative">
                        <input
                          type={showCurrentPin ? "text" : "password"}
                          placeholder={accountInfo?.security_pin || "0000"}
                          value={pinData.currentPin}
                          onChange={(e) => handlePinChange("currentPin", e.target.value)}
                          className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors text-center"
                          maxLength={4}
                        />
                        <button
                          type="button"
                          onClick={() => setShowCurrentPin(!showCurrentPin)}
                          className="absolute right-3 top-1/2 transform -translate-y-1/2 text-white/40 hover:text-white/60 transition-colors"
                        >
                          {showCurrentPin ? (
                            <svg
                              width="16"
                              height="16"
                              viewBox="0 0 24 24"
                              fill="none"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"
                                stroke="currentColor"
                                strokeWidth="2"
                                strokeLinecap="round"
                                strokeLinejoin="round"
                              />
                            </svg>
                          ) : (
                            <svg
                              width="16"
                              height="16"
                              viewBox="0 0 24 24"
                              fill="none"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                d="M12 4.5C7.305 4.5 3.27 7.335 1.5 11.25C3.27 15.165 7.305 18 12 18C16.695 18 20.73 15.165 22.5 11.25C20.73 7.335 16.695 4.5 12 4.5ZM12 15C9.795 15 8 13.205 8 11C8 8.795 9.795 7 12 7C14.205 7 16 8.795 16 11C16 13.205 14.205 15 12 15ZM12 9C10.895 9 10 9.895 10 11C10 12.105 10.895 13 12 13C13.105 13 14 12.105 14 11C14 9.895 13.105 9 12 9Z"
                                fill="currentColor"
                              />
                            </svg>
                          )}
                        </button>
                      </div>
                    </div>

                    <div>
                      <label className="text-white/60 text-sm font-medium mb-2 block">
                        Repetir PIN atual
                      </label>
                      <div className="relative">
                        <input
                          type={showRepeatPin ? "text" : "password"}
                          placeholder="****"
                          value={pinData.repeatPin}
                          onChange={(e) => handlePinChange("repeatPin", e.target.value)}
                          className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors text-center"
                          maxLength={4}
                        />
                        <button
                          type="button"
                          onClick={() => setShowRepeatPin(!showRepeatPin)}
                          className="absolute right-3 top-1/2 transform -translate-y-1/2 text-white/40 hover:text-white/60 transition-colors"
                        >
                          {showRepeatPin ? (
                            <svg
                              width="16"
                              height="16"
                              viewBox="0 0 24 24"
                              fill="none"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"
                                stroke="currentColor"
                                strokeWidth="2"
                                strokeLinecap="round"
                                strokeLinejoin="round"
                              />
                            </svg>
                          ) : (
                            <svg
                              width="16"
                              height="16"
                              viewBox="0 0 24 24"
                              fill="none"
                              xmlns="http://www.w3.org/2000/svg"
                            >
                              <path
                                d="M12 4.5C7.305 4.5 3.27 7.335 1.5 11.25C3.27 15.165 7.305 18 12 18C16.695 18 20.73 15.165 22.5 11.25C20.73 7.335 16.695 4.5 12 4.5ZM12 15C9.795 15 8 13.205 8 11C8 8.795 9.795 7 12 7C14.205 7 16 8.795 16 11C16 13.205 14.205 15 12 15ZM12 9C10.895 9 10 9.895 10 11C10 12.105 10.895 13 12 13C13.105 13 14 12.105 14 11C14 9.895 13.105 9 12 9Z"
                                fill="currentColor"
                              />
                            </svg>
                          )}
                        </button>
                      </div>
                    </div>
                  </div>

                  <div>
                    <label className="text-white/60 text-sm font-medium mb-2 block">
                      Novo PIN
                    </label>
                    <div className="relative">
                      <input
                        type={showNewPin ? "text" : "password"}
                        placeholder="****"
                        value={pinData.newPin}
                        onChange={(e) => handlePinChange("newPin", e.target.value)}
                        className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors text-center"
                        maxLength={4}
                      />
                      <button
                        type="button"
                        onClick={() => setShowNewPin(!showNewPin)}
                        className="absolute right-3 top-1/2 transform -translate-y-1/2 text-white/40 hover:text-white/60 transition-colors"
                      >
                        {showNewPin ? (
                          <svg
                            width="1rem"
                            height="1rem"
                            viewBox="0 0 24 24"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path
                              d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"
                              stroke="currentColor"
                              strokeWidth="2"
                              strokeLinecap="round"
                              strokeLinejoin="round"
                            />
                          </svg>
                        ) : (
                          <svg
                            width="1rem"
                            height="1rem"
                            viewBox="0 0 24 24"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                          >
                            <path
                              d="M12 4.5C7.305 4.5 3.27 7.335 1.5 11.25C3.27 15.165 7.305 18 12 18C16.695 18 20.73 15.165 22.5 11.25C20.73 7.335 16.695 4.5 12 4.5ZM12 15C9.795 15 8 13.205 8 11C8 8.795 9.795 7 12 7C14.205 7 16 8.795 16 11C16 13.205 14.205 15 12 15ZM12 9C10.895 9 10 9.895 10 11C14 12.105 10.895 13 12 13C13.105 13 14 12.105 14 11C14 9.895 13.105 9 12 9Z"
                              fill="currentColor"
                            />
                          </svg>
                        )}
                      </button>
                    </div>
                  </div>

                  <div className="text-white/50 text-xs leading-relaxed pt-4">
                    Caso tenha esquecido ou perdido o PIN, clique em redefinir e
                    automaticamente o PIN será redefinido para 0000.
                  </div>
                </div>
              </div>
            )}
          </div>
          {activeTab === "info" && (
            <div className="w-full flex justify-end">
              <button
                onClick={handleUpdateProfile}
                disabled={isUpdating}
                className="px-8 py-3 bg-[#df5454] hover:bg-[#2E6FB8] disabled:opacity-50 disabled:cursor-not-allowed rounded-md font-medium text-sm transition-all flex items-center justify-center gap-2 text-white"
              >
                {isUpdating ? (
                  <>
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                  </>
                ) : (
                  <>
                    <Check className="w-4 h-4" />
                    ATUALIZAR
                  </>
                )}
              </button>
            </div>
          )}

          {activeTab === "security" && (
            <div className="w-full flex justify-end gap-4 pt-6">
              <button 
                onClick={handleResetPin}
                disabled={isResettingPin}
                className="flex-1 px-6 py-3 border border-[#df5454] text-white/80 hover:text-white rounded-md font-medium text-sm transition-all disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {isResettingPin ? "REDEFININDO..." : "REDEFINIR"}
              </button>
              <button 
                onClick={handleUpdatePin}
                disabled={isUpdating}
                className="flex-1 px-6 py-3 bg-[#df5454] hover:bg-[#2E6FB8] text-white rounded-md font-medium text-sm transition-all disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {isUpdating ? "ATUALIZANDO..." : "ATUALIZAR"}
              </button>
            </div>
          )}
        </div>
      </motion.div>
    </>
  );
}
