import * as motion from "motion/react-client";
import { Separator } from "@views/components/ui/separator";
import TransferHistory from "../../components/TransferHistory";
import { ArrowLeftRight, TrendingUp, User } from "lucide-react";
import { useUserData } from "../../../hooks/useUserData";
import { useSelectedAccount } from "../../../hooks/useSelectedAccount";
import { useJointAccounts } from "../../../hooks/useJointAccounts";
import { useTransferKey } from "../../../hooks/useTransferKey";
import { UserAvatar } from "@views/components/UserAvatar";
import { formatCurrency } from "../../../utils/formatCurrency";
import { useState } from "react";
import { fetchNui } from "../../../app/utils/fetchNui";

export function Transfer() {
  const userData = useUserData();
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();
  const { jointAccounts } = useJointAccounts();
  const { transferKey } = useTransferKey();
  const [pixKey, setPixKey] = useState<string>("");
  const [amount, setAmount] = useState<string>("0");
  const [isTransferring, setIsTransferring] = useState<boolean>(false);

  // Determinar dados da conta atual
  const currentAccountData = (() => {
    if (isPersonalAccount) {
      return {
        name: userData?.name || "Usuário",
        balance: userData?.bank || 0,
        type: "Conta pessoal",
        key: transferKey || userData?.id?.toString() || "0000" // Usar chave de transferência real
      };
    } else if (isJointAccount && selectedAccount) {
      const jointAccount = jointAccounts.find(acc => acc.id.toString() === selectedAccount.id);
      return {
        name: jointAccount?.account_name || "Conta conjunta",
        balance: jointAccount?.balance || 0,
        type: `Conta ${jointAccount?.account_type || 'conjunta'}`,
        key: jointAccount?.id?.toString() || "0000" // Usar ID como chave para contas conjuntas
      };
    }
    return {
      name: userData?.name || "Usuário",
      balance: userData?.bank || 0,
      type: "Conta pessoal",
      key: transferKey || userData?.id?.toString() || "0000"
    };
  })();

  const handlePixKeyChange = (value: string) => {
    setPixKey(value);
  };

  const handleAmountChange = (value: string) => {
    const cleanValue = value.replace(/[^\d.,]/g, "");
    setAmount(cleanValue);
  };

  const handleTransfer = async () => {
    const numericAmount = parseFloat(amount.replace(",", "."));
    if (isNaN(numericAmount) || numericAmount <= 0 || !pixKey.trim()) {
      return;
    }

    setIsTransferring(true);

    try {
      console.log(`Transferindo R$ ${numericAmount} para: ${pixKey}`);

      // Chamar o callback de transferência
      const result = await fetchNui<{ success: boolean; message?: string; type?: string; newBalance?: number }>('transfer', {
        amount: numericAmount,
        target_key: pixKey.trim(),
        accountType: isJointAccount ? 'joint' : 'personal',
        accountId: selectedAccount?.id
      });

      if (result && result.success) {
        console.log('Transferência realizada com sucesso:', result);
        
        // Reset form após sucesso
        setPixKey("");
        setAmount("0");
        
        // Atualizar saldo na interface se necessário
        if (result.newBalance !== undefined) {
          // O saldo será atualizado automaticamente quando os dados forem recarregados
          console.log('Novo saldo:', result.newBalance);
        }
      } else {
        console.error('Erro na transferência:', result?.message);
        // Aqui você pode adicionar uma notificação de erro se desejar
      }
    } catch (error) {
      console.error("Erro na transferência:", error);
    } finally {
      setIsTransferring(false);
    }
  };

  const formatAmount = (value: string) => {
    if (!value || value === "0") return "R$ 0";

    const numericValue = parseFloat(value.replace(",", "."));
    if (isNaN(numericValue)) return "R$ 0";

    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(numericValue);
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
                d="M14.9929 3.26316L18.7261 6.85923C18.887 7.01407 18.9837 7.22018 18.9981 7.43889C19.0125 7.65759 18.9437 7.87386 18.8045 8.04712L18.7271 8.13171L14.9938 11.7368C14.8263 11.8999 14.6004 11.9951 14.3624 12.0029C14.1245 12.0106 13.8924 11.9304 13.7137 11.7787C13.5351 11.6269 13.4234 11.415 13.4014 11.1864C13.3795 10.9577 13.449 10.7297 13.5958 10.5489L13.6732 10.4643L15.8105 8.40168H5.93331C5.70471 8.40165 5.48407 8.32073 5.31324 8.17426C5.14242 8.02779 5.03328 7.82596 5.00653 7.60706L5 7.50087C5.00003 7.28045 5.08396 7.0677 5.23586 6.90299C5.38776 6.73827 5.59708 6.63304 5.82411 6.60725L5.93331 6.60095H15.817L13.6742 4.53744C13.5133 4.3826 13.4166 4.17648 13.4022 3.95778C13.3877 3.73907 13.4566 3.5228 13.5958 3.34955L13.6732 3.26406C13.8338 3.10898 14.0476 3.01574 14.2744 3.00182C14.5012 2.9879 14.7255 3.05427 14.9052 3.18846L14.9929 3.26316ZM18.9912 16.3947L18.9968 16.5C18.9968 16.7205 18.9128 16.9332 18.7609 17.0979C18.609 17.2626 18.3997 17.3679 18.1727 17.3937L18.0635 17.4H8.18631L10.3264 19.4635C10.4872 19.6183 10.5839 19.8244 10.5984 20.0431C10.6128 20.2618 10.544 20.4781 10.4048 20.6514L10.3273 20.7359C10.1667 20.891 9.95297 20.9843 9.72615 20.9982C9.49933 21.0121 9.27503 20.9457 9.09535 20.8115L9.00762 20.7359L5.27439 17.1399C5.11356 16.985 5.01686 16.7789 5.00242 16.5602C4.98799 16.3415 5.05682 16.1252 5.19599 15.952L5.27346 15.8674L9.00669 12.2641C9.17425 12.101 9.40014 12.0058 9.63811 11.998C9.87609 11.9903 10.1081 12.0705 10.2868 12.2222C10.4654 12.374 10.5772 12.5859 10.5991 12.8145C10.621 13.0431 10.5515 13.2712 10.4048 13.452L10.3273 13.5366L8.19004 15.6001H18.0644C18.293 15.6001 18.5137 15.6811 18.6845 15.8275C18.8553 15.974 18.9645 16.1758 18.9912 16.3947Z"
                fill="#df5454"
              />
            </svg>

            <div className="flex items-center justify-center gap-2">
              <h1 className="text-white text-base font-bold">Transferência</h1>
              <span className="text-white/45 text-xs font-normal">/ Banco</span>
            </div>
          </div>

          <div className="flex items-center gap-6">
            <div className="text-right">
              <div className="text-white text-sm">{currentAccountData.name}</div>
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

        <div className="flex flex-col items-center justify-center gap-4 p-4">
          <div className="flex items-center justify-center gap-4 w-full">
            <div
              className="flex flex-col rounded-md p-6 flex-1 w-[44.25rem] h-[9rem]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="w-full flex items-center justify-between mb-2">
                <div className="flex flex-col items-start">
                  <div className="flex items-center justify-center gap-2">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width=".75rem"
                      height=".625rem"
                      viewBox="0 0 12 10"
                      fill="none"
                    >
                      <path
                        d="M12 9.58334C12 9.69385 11.9579 9.79983 11.8828 9.87796C11.8078 9.9561 11.7061 10 11.6 10H0.4C0.293913 10 0.192172 9.9561 0.117157 9.87796C0.0421427 9.79983 0 9.69385 0 9.58334C0 9.47284 0.0421427 9.36686 0.117157 9.28872C0.192172 9.21059 0.293913 9.16669 0.4 9.16669H11.6C11.7061 9.16669 11.8078 9.21059 11.8828 9.28872C11.9579 9.36686 12 9.47284 12 9.58334ZM0.415 3.8637C0.391209 3.77632 0.395479 3.68324 0.42716 3.59863C0.458842 3.51401 0.516199 3.44249 0.5905 3.39496L5.7905 0.0617184C5.85351 0.0213643 5.92603 0 6 0C6.07397 0 6.14649 0.0213643 6.2095 0.0617184L11.4095 3.39496C11.4838 3.44244 11.5412 3.5139 11.573 3.59848C11.6047 3.68306 11.609 3.77613 11.5853 3.86352C11.5616 3.95091 11.5111 4.02783 11.4416 4.08258C11.372 4.13733 11.2872 4.16691 11.2 4.16682H10V7.50007H10.8C10.9061 7.50007 11.0078 7.54396 11.0828 7.6221C11.1579 7.70024 11.2 7.80622 11.2 7.91672C11.2 8.02723 11.1579 8.1332 11.0828 8.21134C11.0078 8.28948 10.9061 8.33338 10.8 8.33338H1.2C1.09391 8.33338 0.992172 8.28948 0.917157 8.21134C0.842143 8.1332 0.8 8.02723 0.8 7.91672C0.8 7.80622 0.842143 7.70024 0.917157 7.6221C0.992172 7.54396 1.09391 7.50007 1.2 7.50007H2V4.16682H0.8C0.712894 4.16685 0.62816 4.13726 0.55867 4.08255C0.489181 4.02784 0.438736 3.951 0.415 3.8637ZM6.8 7.08341C6.8 7.19391 6.84214 7.29989 6.91716 7.37803C6.99217 7.45617 7.09391 7.50007 7.2 7.50007C7.30609 7.50007 7.40783 7.45617 7.48284 7.37803C7.55786 7.29989 7.6 7.19391 7.6 7.08341V4.58348C7.6 4.47297 7.55786 4.36699 7.48284 4.28886C7.40783 4.21072 7.09391 4.16682 7.2 4.16682C7.09391 4.16682 6.99217 4.21072 6.91716 4.28886C6.84214 4.36699 6.8 4.47297 6.8 4.58348V7.08341ZM4.4 7.08341C4.4 7.19391 4.44214 7.29989 4.51716 7.37803C4.59217 7.45617 4.69391 7.50007 4.8 7.50007C4.90609 7.50007 5.00783 7.45617 5.08284 7.37803C5.15786 7.29989 5.2 7.19391 5.2 7.08341V4.58348C5.2 4.47297 5.15786 4.36699 5.08284 4.28886C5.00783 4.21072 4.90609 4.16682 4.8 4.16682C4.69391 4.16682 4.59217 4.21072 4.51716 4.28886C4.44214 4.36699 4.4 4.47297 4.4 4.58348V7.08341Z"
                        fill="white"
                        fill-opacity="0.25"
                      />
                    </svg>

                    <h1 className="text-white/40 text-sm font-normal">
                      Balanço da sua conta
                    </h1>
                  </div>

                  <div className="flex items-center justify-center gap-2">
                    <h1 className="text-white/50 text-[2rem] font-bold">$</h1>
                    <h1 className="text-white text-[2rem] font-semibold">
                      {formatCurrency(currentAccountData.balance)}
                    </h1>
                  </div>
                </div>
                <svg
                  width="3.5rem"
                  height="3.5rem"
                  viewBox="0 0 56 56"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    width="56"
                    height="56"
                    rx="8"
                    fill="#5BB376"
                    fill-opacity="0.06"
                  />
                  <path
                    d="M40 37.1667C40 37.3877 39.9157 37.5997 39.7657 37.7559C39.6157 37.9122 39.4122 38 39.2 38H16.8C16.5878 38 16.3843 37.9122 16.2343 37.7559C16.0843 37.5997 16 37.3877 16 37.1667C16 36.9457 16.0843 36.7337 16.2343 36.5774C16.3843 36.4212 16.5878 36.3334 16.8 36.3334H39.2C39.4122 36.3334 39.6157 36.4212 39.7657 36.5774C39.9157 36.7337 40 36.9457 40 37.1667ZM16.83 25.7274C16.7824 25.5526 16.791 25.3665 16.8543 25.1973C16.9177 25.028 17.0324 24.885 17.181 24.7899L27.581 18.1234C27.707 18.0427 27.8521 18 28 18C28.1479 18 28.293 18.0427 28.419 18.1234L38.819 24.7899C38.9676 24.8849 39.0824 25.0278 39.1459 25.197C39.2094 25.3661 39.2181 25.5523 39.1706 25.727C39.1232 25.9018 39.0222 26.0557 38.8831 26.1652C38.744 26.2747 38.5744 26.3338 38.4 26.3336H36V33.0001H37.6C37.8122 33.0001 38.0157 33.0879 38.1657 33.2442C38.3157 33.4005 38.4 33.6124 38.4 33.8334C38.4 34.0545 38.3157 34.2664 38.1657 34.4227C38.0157 34.579 37.8122 34.6668 37.6 34.6668H18.4C18.1878 34.6668 17.9843 34.579 17.8343 34.4227C17.6843 34.2664 17.6 34.0545 17.6 33.8334C17.6 33.6124 17.6843 33.4005 17.8343 33.2442C17.9843 33.0879 18.1878 33.0001 18.4 33.0001H20V26.3336H17.6C17.4258 26.3337 17.2563 26.2745 17.1173 26.1651C16.9784 26.0557 16.8775 25.902 16.83 25.7274ZM29.6 32.1668C29.6 32.3878 29.6843 32.5998 29.8343 32.7561C29.9843 32.9123 30.1878 33.0001 30.4 33.0001C30.6122 33.0001 30.8157 32.9123 30.9657 32.7561C31.1157 32.5998 31.2 32.3878 31.2 32.1668V27.167C31.2 26.9459 31.1157 26.734 30.9657 26.5777C30.8157 26.4214 30.6122 26.3336 30.4 26.3336C30.1878 26.3336 29.9843 26.4214 29.8343 26.5777C29.6843 26.734 29.6 26.9459 29.6 27.167V32.1668ZM24.8 32.1668C24.8 32.3878 24.8843 32.5998 25.0343 32.7561C25.1843 32.9123 25.3878 33.0001 25.6 33.0001C25.8122 33.0001 26.0157 32.9123 26.1657 32.7561C26.3157 32.5998 26.4 32.3878 26.4 32.1668V27.167C26.4 26.9459 26.3157 26.734 26.1657 26.5777C26.0157 26.4214 25.8122 26.3336 25.6 26.3336C25.3878 26.3336 25.1843 26.4214 25.0343 26.5777C24.8843 26.734 24.8 26.9459 24.8 27.167V32.1668Z"
                    fill="#5BB376"
                  />
                </svg>
              </div>

              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full text-white/60 text-sm font-normal mt-2">
                Cresceu{" "}
                <span className="text-[#5BB376] text-sm font-medium">
                  +14,96%
                </span>{" "}
                nas últimas 4 semanas.
              </div>
            </div>

            <div
              className="flex flex-col rounded-md p-6 flex-1 w-[26.75rem] h-[9rem]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="w-full flex items-center justify-between mb-2">
                <div className="flex flex-col items-start">
                  <div className="flex items-center justify-center gap-2">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width=".5rem"
                      height=".75rem"
                      viewBox="0 0 8 12"
                      fill="none"
                    >
                      <path
                        d="M4 0C4.56509 0 5.11749 0.175947 5.58734 0.505591C6.0572 0.835235 6.42341 1.30377 6.63966 1.85195C6.85591 2.40013 6.91249 3.00333 6.80224 3.58527C6.692 4.16721 6.41988 4.70176 6.02031 5.12132C5.62073 5.54088 5.11163 5.8266 4.5574 5.94236C4.00317 6.05811 3.42869 5.9987 2.90662 5.77164C2.38454 5.54458 1.93832 5.16006 1.62437 4.66671C1.31043 4.17336 1.14286 3.59334 1.14286 3L1.14571 2.8698C1.17767 2.09745 1.49235 1.36787 2.02413 0.833196C2.55591 0.298525 3.26374 4.46655e-05 4 0ZM5.14286 7.2C5.90062 7.2 6.62734 7.51607 7.16316 8.07868C7.69898 8.64129 8 9.40435 8 10.2V10.8C8 11.1183 7.87959 11.4235 7.66527 11.6485C7.45094 11.8736 7.16025 12 6.85714 12H1.14286C0.839753 12 0.549062 11.8736 0.334735 11.6485C0.120408 11.4235 0 11.1183 0 10.8V10.2C0 9.40435 0.30102 8.64129 0.836838 8.07868C1.37266 7.51607 2.09938 7.2 2.85714 7.2H5.14286Z"
                        fill="white"
                        fill-opacity="0.25"
                      />
                    </svg>
                    <h1 className="text-white/40 text-sm font-normal">
                      Minha chave
                    </h1>
                  </div>

                  <div className="flex items-center justify-center gap-2">
                    <h1 className="text-white text-[2rem] font-semibold">
                      {currentAccountData.key}
                    </h1>
                  </div>
                </div>
                <svg
                  width="3.5rem"
                  height="3.5rem"
                  viewBox="0 0 56 56"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    width="56"
                    height="56"
                    rx="8"
                    fill="#df5454"
                    fill-opacity="0.06"
                  />
                  <path
                    d="M28 19C28.8476 19 29.6762 19.2639 30.381 19.7584C31.0858 20.2529 31.6351 20.9557 31.9595 21.7779C32.2839 22.6002 32.3687 23.505 32.2034 24.3779C32.038 25.2508 31.6298 26.0526 31.0305 26.682C30.4311 27.3113 29.6674 27.7399 28.8361 27.9135C28.0048 28.0872 27.143 27.9981 26.3599 27.6575C25.5768 27.3169 24.9075 26.7401 24.4366 26.0001C23.9656 25.26 23.7143 24.39 23.7143 23.5L23.7186 23.3047C23.7665 22.1462 24.2385 21.0518 25.0362 20.2498C25.8339 19.4478 26.8956 19.0001 28 19ZM29.7143 29.8C30.8509 29.8 31.941 30.2741 32.7447 31.118C33.5485 31.9619 34 33.1065 34 34.3V35.2C34 35.6774 33.8194 36.1352 33.4979 36.4728C33.1764 36.8104 32.7404 37 32.2857 37H23.7143C23.2596 37 22.8236 36.8104 22.5021 36.4728C22.1806 36.1352 22 35.6774 22 35.2V34.3C22 33.1065 22.4515 31.9619 23.2553 31.118C24.059 30.2741 25.1491 29.8 26.2857 29.8H29.7143Z"
                    fill="#df5454"
                  />
                </svg>
              </div>

              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full text-white/60 text-sm font-normal mt-3">
                Passe essas informações para receber transferências.
              </div>
            </div>
          </div>

          <div className="w-full flex items-center justify-center h-[12.25rem]">
            <div
              className="flex flex-col rounded-md p-6 w-full"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="flex items-center gap-2 mb-4">
                <ArrowLeftRight className="w-3 h-3 text-white/25" />
                <h3 className="text-white/40 text-sm font-normal">
                  Transferir
                </h3>
              </div>

              <div className="space-y-4 w-full">
                <div className="flex items-end gap-4 w-full">
                  <div className="flex-1">
                    <label className="text-white/60 text-sm font-medium mb-2 block">
                      Chave
                    </label>
                    <input
                      type="text"
                      value={pixKey}
                      onChange={(e) => handlePixKeyChange(e.target.value)}
                      placeholder="EX: 123"
                      className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors"
                    />
                  </div>

                  <div className="flex-1">
                    <label className="text-white/60 text-sm font-medium mb-2 block">
                      Valor
                    </label>
                    <input
                      type="text"
                      value={amount}
                      onChange={(e) => handleAmountChange(e.target.value)}
                      placeholder="R$ 0"
                      className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white text-center placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors"
                    />
                  </div>
                </div>

                <button
                  onClick={handleTransfer}
                  disabled={
                    isTransferring ||
                    !pixKey.trim() ||
                    !amount ||
                    amount === "0" ||
                    parseFloat(amount.replace(",", ".")) <= 0
                  }
                  className="w-full h-[3rem] bg-[#df5454] hover:bg-[#2E6BB8] disabled:opacity-50 disabled:cursor-not-allowed rounded-md font-medium text-sm transition-all flex items-center justify-center gap-2 text-white"
                >
                  {isTransferring ? (
                    <>
                      <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                      PROCESSANDO...
                    </>
                  ) : (
                    <>
                      <ArrowLeftRight size={16} />
                      TRANSFERIR
                    </>
                  )}
                </button>
              </div>
            </div>
          </div>

          <div className="w-full flex items-center justify-center h-[18.75rem]">
            <TransferHistory className="w-full" />
          </div>
        </div>
      </motion.div>
    </>
  );
}
