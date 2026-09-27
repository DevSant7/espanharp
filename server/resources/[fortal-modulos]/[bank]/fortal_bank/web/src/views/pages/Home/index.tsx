import * as motion from "motion/react-client";
import { Separator } from "@views/components/ui/separator";
import CustomBalanceChart from "@views/components/CustomBalanceChart";
import TransactionTable from "@views/components/TransactionTable";
import QuickActions from "@views/components/QuickActions";
import { useUserData } from "../../../hooks/useUserData";
import { formatCurrency } from "../../../utils/formatCurrency";
import { useExpenses } from "../../../hooks/useExpenses";
import { useSelectedAccount } from "../../../hooks/useSelectedAccount";
import { useJointAccounts } from "../../../hooks/useJointAccounts";
import { UserAvatar } from "@views/components/UserAvatar";
import { fetchNui } from "../../../app/utils/fetchNui";

import { useState } from "react";

// Declaração de tipos para window
declare global {
  interface Window {
    refreshTransactions?: () => void;
    refreshBalanceChart?: () => void;
  }
}

export function Home() {
  const userData = useUserData();
  const { expenses, refreshExpenses } = useExpenses();
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();
  const { jointAccounts, refreshJointAccounts } = useJointAccounts();
  
  console.log('FORTAL_BANK: Home component renderizando - userData:', userData);
  console.log('FORTAL_BANK: Home component - selectedAccount:', selectedAccount);
  
  // Determinar dados da conta atual
  const currentAccountData = (() => {
    if (isPersonalAccount) {
      return {
        name: userData?.name || "Usuário",
        balance: userData?.bank || 0,
        type: "Conta pessoal"
      };
    } else if (isJointAccount && selectedAccount) {
      const jointAccount = jointAccounts.find(acc => acc.id.toString() === selectedAccount.id);
      return {
        name: jointAccount?.account_name || "Conta conjunta",
        balance: jointAccount?.balance || 0,
        type: `Conta ${jointAccount?.account_type || 'conjunta'}`
      };
    }
    return {
      name: userData?.name || "Usuário",
      balance: userData?.bank || 0,
      type: "Conta pessoal"
    };
  })();
  
  console.log('FORTAL_BANK: currentAccountData:', currentAccountData);

  const handleDeposit = async (amount: number) => {
    console.log(`Depositando: R$ ${amount} na conta:`, currentAccountData.type);
    
    try {
      const result = await fetchNui('deposit', { 
        amount,
        accountType: isJointAccount ? 'joint' : 'personal',
        accountId: selectedAccount?.id
      });
      
      if (result.success) {
        console.log('Depósito realizado com sucesso:', result.message);
        // Atualizar dados do usuário apenas se for conta pessoal
        if (result.newBalance !== undefined && isPersonalAccount) {
          // Enviar mensagem para atualizar os dados do usuário
          window.postMessage({
            action: "setUserData",
            data: {
              ...userData,
              bank: result.newBalance
            }
          }, "*");
        } else if (result.newBalance !== undefined && isJointAccount) {
          // Para contas conjuntas, atualizar a lista de contas conjuntas
          console.log('Atualizando saldo da conta conjunta:', result.newBalance);
          // Recarregar dados das contas conjuntas
          refreshJointAccounts();
        }
        
        // Atualizar transações e despesas em tempo real
        console.log('Tentando atualizar transações após depósito...', typeof window.refreshTransactions);
        if (window.refreshTransactions) {
          console.log('Chamando window.refreshTransactions()');
          window.refreshTransactions();
        } else {
          console.log('window.refreshTransactions não está definida');
        }
        
        // Atualizar despesas e gráfico
        refreshExpenses();
        if (window.refreshBalanceChart) {
          window.refreshBalanceChart();
        }
      } else {
        console.error('Erro no depósito:', result.message);
      }
    } catch (error) {
      console.error('Erro ao processar depósito:', error);
    }
  };

  const handleWithdraw = async (amount: number) => {
    console.log(`Sacando: R$ ${amount} da conta:`, currentAccountData.type);
    
    try {
      const result = await fetchNui('withdraw', { 
        amount,
        accountType: isJointAccount ? 'joint' : 'personal',
        accountId: selectedAccount?.id
      });
      
      if (result.success) {
        console.log('Saque realizado com sucesso:', result.message);
        // Atualizar dados do usuário apenas se for conta pessoal
        if (result.newBalance !== undefined && isPersonalAccount) {
          // Enviar mensagem para atualizar os dados do usuário
          window.postMessage({
            action: "setUserData",
            data: {
              ...userData,
              bank: result.newBalance
            }
          }, "*");
        } else if (result.newBalance !== undefined && isJointAccount) {
          // Para contas conjuntas, atualizar a lista de contas conjuntas
          console.log('Atualizando saldo da conta conjunta:', result.newBalance);
          // Recarregar dados das contas conjuntas
          refreshJointAccounts();
        }
        
        // Atualizar transações e despesas em tempo real
        console.log('Tentando atualizar transações após saque...', typeof window.refreshTransactions);
        if (window.refreshTransactions) {
          console.log('Chamando window.refreshTransactions()');
          window.refreshTransactions();
        } else {
          console.log('window.refreshTransactions não está definida');
        }
        
        // Atualizar despesas e gráfico
        refreshExpenses();
        if (window.refreshBalanceChart) {
          window.refreshBalanceChart();
        }
      } else {
        console.error('Erro no saque:', result.message);
      }
    } catch (error) {
      console.error('Erro ao processar saque:', error);
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
                d="M5 12C5 12.2063 5.08194 12.4041 5.22781 12.55C5.37367 12.6958 5.5715 12.7778 5.77778 12.7778H10.4444C10.6507 12.7778 10.8486 12.6958 10.9944 12.55C11.1403 12.4041 11.2222 12.2063 11.2222 12V5.77778C11.2222 5.5715 11.1403 5.37367 10.9944 5.22781C10.8486 5.08194 10.6507 5 10.4444 5H5.77778C5.5715 5 5.37367 5.08194 5.22781 5.22781C5.08194 5.37367 5 5.5715 5 5.77778V12ZM5 18.2222C5 18.4285 5.08194 18.6263 5.22781 18.7722C5.37367 18.9181 5.5715 19 5.77778 19H10.4444C10.6507 19 10.8486 18.9181 10.9944 18.7722C11.1403 18.6263 11.2222 18.4285 11.2222 18.2222V15.1111C11.2222 14.9048 11.1403 14.707 10.9944 14.5611C10.8486 14.4153 10.6507 14.3333 10.4444 14.3333H5.77778C5.5715 14.3333 5.37367 14.4153 5.22781 14.5611C5.08194 14.707 5 14.9048 5 15.1111V18.2222ZM12.7778 18.2222C12.7778 18.4285 12.8597 18.6263 13.0056 18.7722C13.1514 18.9181 13.3493 19 13.5556 19H18.2222C18.4285 19 18.6263 18.9181 18.7722 18.7722C18.9181 18.6263 19 18.4285 19 18.2222V12C19 11.7937 18.9181 11.5959 18.7722 11.45C18.6263 11.3042 18.4285 11.2222 18.2222 11.2222H13.5556C13.3493 11.2222 13.1514 11.3042 13.0056 11.45C12.8597 11.5959 12.7778 11.7937 12.7778 12V18.2222ZM13.5556 5C13.3493 5 13.1514 5.08194 13.0056 5.22781C12.8597 5.37367 12.7778 5.5715 12.7778 5.77778V8.88889C12.7778 9.09517 12.8597 9.293 13.0056 9.43886C13.1514 9.58472 13.3493 9.66667 13.5556 9.66667H18.2222C18.4285 9.66667 18.6263 9.58472 18.7722 9.43886C18.9181 9.293 19 9.09517 19 8.88889V5.77778C19 5.5715 18.9181 5.37367 18.7722 5.22781C18.6263 5.08194 18.4285 5 18.2222 5H13.5556Z"
                fill="#df5454"
              />
            </svg>
            <div className="flex items-center justify-center gap-2">
              <h1 className="text-white text-base font-bold">Dashboard</h1>
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
          <div className="flex-1 self-stretch flex items-center justify-center gap-4">
            <div
              className="flex flex-col items-center justify-center rounded-md p-6 max-h-[9rem]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="w-full flex items-center justify-between ">
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
                        d="M12 9.58334C12 9.69385 11.9579 9.79983 11.8828 9.87796C11.8078 9.9561 11.7061 10 11.6 10H0.4C0.293913 10 0.192172 9.9561 0.117157 9.87796C0.0421427 9.79983 0 9.69385 0 9.58334C0 9.47284 0.0421427 9.36686 0.117157 9.28872C0.192172 9.21059 0.293913 9.16669 0.4 9.16669H11.6C11.7061 9.16669 11.8078 9.21059 11.8828 9.28872C11.9579 9.36686 12 9.47284 12 9.58334ZM0.415 3.8637C0.391209 3.77632 0.395479 3.68324 0.42716 3.59863C0.458842 3.51401 0.516199 3.44249 0.5905 3.39496L5.7905 0.0617184C5.85351 0.0213643 5.92603 0 6 0C6.07397 0 6.14649 0.0213643 6.2095 0.0617184L11.4095 3.39496C11.4838 3.44244 11.5412 3.5139 11.573 3.59848C11.6047 3.68306 11.609 3.77613 11.5853 3.86352C11.5616 3.95091 11.5111 4.02783 11.4416 4.08258C11.372 4.13733 11.2872 4.16691 11.2 4.16682H10V7.50007H10.8C10.9061 7.50007 11.0078 7.54396 11.0828 7.6221C11.1579 7.70024 11.2 7.80622 11.2 7.91672C11.2 8.02723 11.1579 8.1332 11.0828 8.21134C11.0078 8.28948 10.9061 8.33338 10.8 8.33338H1.2C1.09391 8.33338 0.992172 8.28948 0.917157 8.21134C0.842143 8.1332 0.8 8.02723 0.8 7.91672C0.8 7.80622 0.842143 7.70024 0.917157 7.6221C0.992172 7.54396 1.09391 7.50007 1.2 7.50007H2V4.16682H0.8C0.712894 4.16685 0.62816 4.13726 0.55867 4.08255C0.489181 4.02784 0.438736 3.951 0.415 3.8637ZM6.8 7.08341C6.8 7.19391 6.84214 7.29989 6.91716 7.37803C6.99217 7.45617 7.09391 7.50007 7.2 7.50007C7.30609 7.50007 7.40783 7.45617 7.48284 7.37803C7.55786 7.29989 7.6 7.19391 7.6 7.08341V4.58348C7.6 4.47297 7.55786 4.36699 7.48284 4.28886C7.40783 4.21072 7.30609 4.16682 7.2 4.16682C7.09391 4.16682 6.99217 4.21072 6.91716 4.28886C6.84214 4.36699 6.8 4.47297 6.8 4.58348V7.08341ZM4.4 7.08341C4.4 7.19391 4.44214 7.29989 4.51716 7.37803C4.59217 7.45617 4.69391 7.50007 4.8 7.50007C4.90609 7.50007 5.00783 7.45617 5.08284 7.37803C5.15786 7.29989 5.2 7.19391 5.2 7.08341V4.58348C5.2 4.47297 5.15786 4.36699 5.08284 4.28886C5.00783 4.21072 4.90609 4.16682 4.8 4.16682C4.69391 4.16682 4.59217 4.21072 4.51716 4.28886C4.44214 4.36699 4.4 4.47297 4.4 4.58348V7.08341Z"
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
                  width="3.5625rem"
                  height="3.5rem"
                  viewBox="0 0 57 56"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    x="0.333496"
                    width="56"
                    height="56"
                    rx="8"
                    fill="#5BB376"
                    fill-opacity="0.06"
                  />
                  <path
                    d="M40.3335 37.1667C40.3335 37.3877 40.2492 37.5997 40.0992 37.7559C39.9492 37.9122 39.7457 38 39.5335 38H17.1335C16.9213 38 16.7178 37.9122 16.5678 37.7559C16.4178 37.5997 16.3335 37.3877 16.3335 37.1667C16.3335 36.9457 16.4178 36.7337 16.5678 36.5774C16.7178 36.4212 16.9213 36.3334 17.1335 36.3334H39.5335C39.7457 36.3334 39.9492 36.4212 40.0992 36.5774C40.2492 36.7337 40.3335 36.9457 40.3335 37.1667ZM17.1635 25.7274C17.1159 25.5526 17.1245 25.3665 17.1878 25.1973C17.2512 25.028 17.3659 24.885 17.5145 24.7899L27.9145 18.1234C28.0405 18.0427 28.1856 18 28.3335 18C28.4814 18 28.6265 18.0427 28.7525 18.1234L39.1525 24.7899C39.3011 24.8849 39.4159 25.0278 39.4794 25.197C39.5429 25.3661 39.5516 25.5523 39.5041 25.727C39.4567 25.9018 39.3557 26.0557 39.2166 26.1652C39.0775 26.2747 38.9079 26.3338 38.7335 26.3336H36.3335V33.0001H37.9335C38.1457 33.0001 38.3492 33.0879 38.4992 33.2442C38.6492 33.4005 38.7335 33.6124 38.7335 33.8334C38.7335 34.0545 38.6492 34.2664 38.4992 34.4227C38.3492 34.579 38.1457 34.6668 37.9335 34.6668H18.7335C18.5213 34.6668 18.3178 34.579 18.1678 34.4227C18.0178 34.2664 17.9335 34.0545 17.9335 33.8334C17.9335 33.6124 18.0178 33.4005 18.1678 33.2442C18.3178 33.0879 18.5213 33.0001 18.7335 33.0001H20.3335V26.3336H17.9335C17.7593 26.3337 17.5898 26.2745 17.4508 26.1651C17.3119 26.0557 17.211 25.902 17.1635 25.7274ZM29.9335 32.1668C29.9335 32.3878 30.0178 32.5998 30.1678 32.7561C30.3178 32.9123 30.5213 33.0001 30.7335 33.0001C30.9457 33.0001 31.1492 32.9123 31.2992 32.7561C31.4492 32.5998 31.5335 32.3878 31.5335 32.1668V27.167C31.5335 26.9459 31.4492 26.734 31.2992 26.5777C31.1492 26.4214 30.9457 26.3336 30.7335 26.3336C30.5213 26.3336 30.3178 26.4214 30.1678 26.5777C30.0178 26.734 29.9335 26.9459 29.9335 27.167V32.1668ZM25.1335 32.1668C25.1335 32.3878 25.2178 32.5998 25.3678 32.7561C25.5178 32.9123 25.7213 33.0001 25.9335 33.0001C26.1457 33.0001 26.3492 32.9123 26.4992 32.7561C26.6492 32.5998 26.7335 32.3878 26.7335 32.1668V27.167C26.7335 26.9459 26.6492 26.734 26.4992 26.5777C26.3492 26.4214 26.1457 26.3336 25.9335 26.3336C25.7213 26.3336 25.5178 26.4214 25.3678 26.5777C25.2178 26.734 25.1335 26.9459 25.1335 27.167V32.1668Z"
                    fill="#5BB376"
                  />
                </svg>
              </div>
              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full flex items-center justify-between">
                <div className="text-white/60 text-sm font-normal">
                  Cresceu{" "}
                  <span className="text-[#5BB376] text-sm font-medium">
                    +14,96%
                  </span>{" "}
                  nas últimas 4 semanas.
                </div>
                <svg
                  width="2.5rem"
                  height="2.5rem"
                  viewBox="0 0 40 40"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g filter="url(#filter0_d_176_463)">
                    <path
                      d="M24.8144 16.3509C24.8211 15.884 24.4474 15.5103 23.9806 15.517L18.0048 15.6025C17.538 15.6092 17.1535 15.9937 17.1468 16.4606C17.1401 16.9274 17.5138 17.3011 17.9806 17.2944L21.919 17.2362L16.1078 23.0474C15.7725 23.3827 15.7649 23.9168 16.0907 24.2426C16.4165 24.5684 16.9506 24.5607 17.2859 24.2255L23.0952 18.4161L23.0408 22.3508C23.0341 22.8176 23.4077 23.1913 23.8746 23.1846C24.3415 23.1779 24.726 22.7934 24.7327 22.3266L24.8181 16.3508L24.8144 16.3509Z"
                      fill="#5BB376"
                    />
                  </g>
                  <defs>
                    <filter
                      id="filter0_d_176_463"
                      x="0.851074"
                      y="0.51709"
                      width="38.9673"
                      height="38.9648"
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
                        values="0 0 0 0 0.301961 0 0 0 0 0.823529 0 0 0 0 0.4 0 0 0 0.15 0"
                      />
                      <feBlend
                        mode="normal"
                        in2="BackgroundImageFix"
                        result="effect1_dropShadow_176_463"
                      />
                      <feBlend
                        mode="normal"
                        in="SourceGraphic"
                        in2="effect1_dropShadow_176_463"
                        result="shape"
                      />
                    </filter>
                  </defs>
                </svg>
              </div>
            </div>

            <div
              className="flex-1 self-stretch flex flex-col items-center justify-center rounded-md p-6 max-h-[9rem]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="w-full flex items-center justify-between">
                <div className="flex flex-col items-start">
                  <div className="flex items-center justify-center gap-2">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width=".8125rem"
                      height=".375rem"
                      viewBox="0 0 13 6"
                      fill="none"
                    >
                      <path
                        fill-rule="evenodd"
                        clip-rule="evenodd"
                        d="M2.62725 1.69377C2.74281 1.43778 2.76491 1.14937 2.68972 0.87876C2.61453 0.608151 2.44681 0.372488 2.21575 0.21281C1.9847 0.0531324 1.70496 -0.0204435 1.42525 0.0048956C1.14554 0.0302346 0.883571 0.152883 0.684974 0.351483C0.486377 0.550082 0.36373 0.81205 0.338392 1.09177C0.313053 1.37148 0.386627 1.65123 0.546303 1.88228C0.705979 2.11334 0.941639 2.28106 1.21225 2.35626C1.48285 2.43145 1.77126 2.40934 2.02724 2.29378L3.43966 3.70622C3.35719 3.88898 3.32183 4.0895 3.33681 4.28945C3.3518 4.48941 3.41664 4.68242 3.52543 4.85085C3.63421 5.01929 3.78347 5.15778 3.95956 5.25368C4.13565 5.34957 4.33296 5.39982 4.53347 5.39982C4.73398 5.39982 4.9313 5.34957 5.10739 5.25368C5.28348 5.15778 5.43274 5.01929 5.54152 4.85085C5.65031 4.68242 5.71515 4.48941 5.73013 4.28945C5.74512 4.0895 5.70976 3.88898 5.62729 3.70622L7.0397 2.29378C7.1949 2.36385 7.36323 2.40009 7.53351 2.40009C7.70379 2.40009 7.87212 2.36385 8.02732 2.29378L10.0397 4.30623C9.92418 4.56222 9.90208 4.85063 9.97727 5.12124C10.0525 5.39185 10.2202 5.62751 10.4512 5.78719C10.6823 5.94687 10.962 6.02044 11.2417 5.9951C11.5215 5.96977 11.7834 5.84712 11.982 5.64852C12.1806 5.44992 12.3033 5.18795 12.3286 4.90823C12.3539 4.62852 12.2804 4.34877 12.1207 4.11772C11.961 3.88666 11.7254 3.71894 11.4547 3.64374C11.1841 3.56855 10.8957 3.59066 10.6397 3.70622L8.62732 1.69377C8.70979 1.511 8.74515 1.31048 8.73017 1.11053C8.71519 0.910579 8.65034 0.717569 8.54156 0.549133C8.43277 0.380696 8.28352 0.242203 8.10743 0.146307C7.93133 0.0504104 7.73402 0.000167928 7.53351 0.000167928C7.333 0.000167928 7.13569 0.0504104 6.9596 0.146307C6.7835 0.242203 6.63425 0.380696 6.52546 0.549133C6.41668 0.717569 6.35183 0.910579 6.33685 1.11053C6.32187 1.31048 6.35723 1.511 6.4397 1.69377L5.02728 3.1062C4.87209 3.03613 4.70375 2.99989 4.53347 2.99989C4.36319 2.99989 4.19486 3.03613 4.03967 3.1062L2.62725 1.69377Z"
                        fill="white"
                        fill-opacity="0.25"
                      />
                    </svg>

                    <h1 className="text-white/40 text-sm font-normal">
                      Despesas
                    </h1>
                  </div>

                  <div className="flex items-center justify-center gap-2">
                    <h1 className="text-white text-[2rem] font-semibold">
                      {formatCurrency(expenses)}
                    </h1>
                  </div>
                </div>
                <svg
                  width="3.5625rem"
                  height="3.5rem"
                  viewBox="0 0 57 56"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    x="0.666992"
                    width="56"
                    height="56"
                    rx="8"
                    fill="#B35B5B"
                    fill-opacity="0.06"
                  />
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M21.2545 25.3875C21.4856 24.8756 21.5298 24.2987 21.3794 23.7575C21.2291 23.2163 20.8936 22.745 20.4315 22.4256C19.9694 22.1063 19.4099 21.9591 18.8505 22.0098C18.2911 22.0605 17.7671 22.3058 17.3699 22.703C16.9728 23.1002 16.7275 23.6241 16.6768 24.1835C16.6261 24.743 16.7733 25.3025 17.0926 25.7646C17.412 26.2267 17.8833 26.5621 18.4245 26.7125C18.9657 26.8629 19.5425 26.8187 20.0545 26.5876L22.8793 29.4124C22.7144 29.778 22.6437 30.179 22.6736 30.5789C22.7036 30.9788 22.8333 31.3648 23.0509 31.7017C23.2684 32.0386 23.5669 32.3156 23.9191 32.5074C24.2713 32.6991 24.6659 32.7996 25.0669 32.7996C25.468 32.7996 25.8626 32.6991 26.2148 32.5074C26.567 32.3156 26.8655 32.0386 27.083 31.7017C27.3006 31.3648 27.4303 30.9788 27.4603 30.5789C27.4902 30.179 27.4195 29.778 27.2546 29.4124L30.0794 26.5876C30.3898 26.7277 30.7265 26.8002 31.067 26.8002C31.4076 26.8002 31.7442 26.7277 32.0546 26.5876L36.0795 30.6125C35.8484 31.1244 35.8042 31.7013 35.9545 32.2425C36.1049 32.7837 36.4404 33.255 36.9025 33.5744C37.3646 33.8937 37.9241 34.0409 38.4835 33.9902C39.0429 33.9395 39.5668 33.6942 39.964 33.297C40.3612 32.8998 40.6065 32.3759 40.6572 31.8165C40.7079 31.257 40.5607 30.6975 40.2414 30.2354C39.922 29.7733 39.4507 29.4379 38.9095 29.2875C38.3683 29.1371 37.7915 29.1813 37.2795 29.4124L33.2546 25.3875C33.4196 25.022 33.4903 24.621 33.4603 24.2211C33.4304 23.8212 33.3007 23.4351 33.0831 23.0983C32.8655 22.7614 32.567 22.4844 32.2149 22.2926C31.8627 22.1008 31.468 22.0003 31.067 22.0003C30.666 22.0003 30.2714 22.1008 29.9192 22.2926C29.567 22.4844 29.2685 22.7614 29.0509 23.0983C28.8334 23.4351 28.7037 23.8212 28.6737 24.2211C28.6437 24.621 28.7145 25.022 28.8794 25.3875L26.0546 28.2124C25.7442 28.0723 25.4075 27.9998 25.0669 27.9998C24.7264 27.9998 24.3897 28.0723 24.0793 28.2124L21.2545 25.3875Z"
                    fill="#B35B5B"
                  />
                </svg>
              </div>
              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full flex items-center justify-between">
                <div className="text-white/60 text-sm font-normal">
                  Nas últimas 4 semanas.
                </div>
                <svg
                  width="2.5rem"
                  height="2.5rem"
                  viewBox="0 0 40 40"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g filter="url(#filter0_d_176_480)">
                    <path
                      d="M15.1861 23.6491C15.1794 24.116 15.5531 24.4897 16.0199 24.483L21.9957 24.3975C22.4625 24.3908 22.847 24.0063 22.8537 23.5394C22.8604 23.0726 22.4867 22.6989 22.0199 22.7056L18.0815 22.7638L23.8927 16.9526C24.2279 16.6173 24.2356 16.0832 23.9098 15.7574C23.584 15.4316 23.0499 15.4393 22.7146 15.7745L16.9053 21.5839L16.9597 17.6492C16.9664 17.1824 16.5927 16.8087 16.1259 16.8154C15.659 16.8221 15.2745 17.2066 15.2678 17.6734L15.1823 23.6492L15.1861 23.6491Z"
                      fill="#B35B5B"
                    />
                  </g>
                  <defs>
                    <filter
                      id="filter0_d_176_480"
                      x="0.182129"
                      y="0.518066"
                      width="38.9673"
                      height="38.9648"
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
                        values="0 0 0 0 0.701961 0 0 0 0 0.356863 0 0 0 0 0.356863 0 0 0 0.15 0"
                      />
                      <feBlend
                        mode="normal"
                        in2="BackgroundImageFix"
                        result="effect1_dropShadow_176_480"
                      />
                      <feBlend
                        mode="normal"
                        in="SourceGraphic"
                        in2="effect1_dropShadow_176_480"
                        result="shape"
                      />
                    </filter>
                  </defs>
                </svg>
              </div>
            </div>

            <div
              className="flex-1 self-stretch flex flex-col items-center justify-center rounded-md p-6 border border-[#df5454] max-h-[9rem]"
              style={{
                background:
                  "radial-gradient(272.33% 149.42% at -6.74% 127.5%, rgba(60, 142, 220, 0.05) 0%, rgba(60, 142, 220, 0.00) 100%), radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="w-full flex items-center justify-between">
                <div className="flex flex-col items-start">
                  <div className="flex items-center justify-center gap-2">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width=".8125rem"
                      height=".625rem"
                      viewBox="0 0 13 10"
                      fill="none"
                    >
                      <path
                        d="M12.6665 0.625C12.6665 0.279822 12.3837 0 12.0349 0H10.1402C9.79138 0 9.50861 0.279822 9.50861 0.625V9.375C9.50861 9.72018 9.79138 10 10.1402 10H12.0349C12.3837 10 12.6665 9.72018 12.6665 9.375V0.625Z"
                        fill="#df5454"
                      />
                      <path
                        d="M8.24545 3.75C8.24545 3.40482 7.96268 3.125 7.61387 3.125H5.71914C5.37032 3.125 5.08756 3.40482 5.08756 3.75V9.375C5.08756 9.72018 5.37032 10 5.71914 10H7.61387C7.96268 10 8.24545 9.72018 8.24545 9.375V3.75Z"
                        fill="#df5454"
                      />
                      <path
                        d="M3.8244 7.5C3.8244 7.15482 3.54163 6.875 3.19282 6.875H1.29808C0.949271 6.875 0.666504 7.15482 0.666504 7.5V9.375C0.666504 9.72018 0.949271 10 1.29808 10H3.19282C3.54163 10 3.8244 9.72018 3.8244 9.375V7.5Z"
                        fill="#df5454"
                      />
                    </svg>

                    <h1 className="text-white text-sm font-normal">
                      CDB 115% 🔥
                    </h1>
                  </div>

                  <div className="flex items-center justify-center gap-2">
                    <h1 className="text-white/50 text-[2rem] font-bold">$</h1>
                    <h1 className="text-white text-[2rem] font-semibold">
                      1,945,694
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
                    d="M39 20.125C39 19.5037 38.4816 19 37.8421 19H34.3684C33.7289 19 33.2105 19.5037 33.2105 20.125V35.875C33.2105 36.4963 33.7289 37 34.3684 37H37.8421C38.4816 37 39 36.4963 39 35.875V20.125Z"
                    fill="#df5454"
                  />
                  <path
                    d="M30.8947 25.75C30.8947 25.1287 30.3763 24.625 29.7368 24.625H26.2632C25.6237 24.625 25.1053 25.1287 25.1053 25.75V35.875C25.1053 36.4963 25.6237 37 26.2632 37H29.7368C30.3763 37 30.8947 36.4963 30.8947 35.875V25.75Z"
                    fill="#df5454"
                  />
                  <path
                    d="M22.7895 32.5C22.7895 31.8787 22.2711 31.375 21.6316 31.375H18.1579C17.5184 31.375 17 31.8787 17 32.5V35.875C17 36.4963 17.5184 37 18.1579 37H21.6316C22.2711 37 22.7895 36.4963 22.7895 35.875V32.5Z"
                    fill="#df5454"
                  />
                </svg>
              </div>
              <Separator className="w-full h-[0.0625rem] bg-white/[.03]" />

              <div className="w-full flex items-center justify-between">
                <div className="text-white/60 text-sm font-normal">
                  Lucrou{" "}
                  <span className="text-[#5BB376] text-sm font-medium">
                    $49,583
                  </span>{" "}
                  nas últimas 24 horas.
                </div>
                <svg
                  width="2.5rem"
                  height="2.5rem"
                  viewBox="0 0 40 40"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g filter="url(#filter0_d_176_463)">
                    <path
                      d="M24.8144 16.3509C24.8211 15.884 24.4474 15.5103 23.9806 15.517L18.0048 15.6025C17.538 15.6092 17.1535 15.9937 17.1468 16.4606C17.1401 16.9274 17.5138 17.3011 17.9806 17.2944L21.919 17.2362L16.1078 23.0474C15.7725 23.3827 15.7649 23.9168 16.0907 24.2426C16.4165 24.5684 16.9506 24.5607 17.2859 24.2255L23.0952 18.4161L23.0408 22.3508C23.0341 22.8176 23.4077 23.1913 23.8746 23.1846C24.3415 23.1779 24.726 22.7934 24.7327 22.3266L24.8181 16.3508L24.8144 16.3509Z"
                      fill="#5BB376"
                    />
                  </g>
                  <defs>
                    <filter
                      id="filter0_d_176_463"
                      x="0.851074"
                      y="0.51709"
                      width="38.9673"
                      height="38.9648"
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
                        values="0 0 0 0 0.301961 0 0 0 0 0.823529 0 0 0 0 0.4 0 0 0 0.15 0"
                      />
                      <feBlend
                        mode="normal"
                        in2="BackgroundImageFix"
                        result="effect1_dropShadow_176_463"
                      />
                      <feBlend
                        mode="normal"
                        in="SourceGraphic"
                        in2="effect1_dropShadow_176_463"
                        result="shape"
                      />
                    </filter>
                  </defs>
                </svg>
              </div>
            </div>
          </div>
          <div className="flex items-center justify-center gap-4">
            <div
              className="w-[25rem] h-[17.5rem] flex flex-col items-start justify-center p-6 gap-4 rounded-md"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
              }}
            >
              <div className="flex items-center justify-start gap-[.56rem]">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width=".625rem"
                  height=".625rem"
                  viewBox="0 0 10 10"
                  fill="none"
                >
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M0 10V2.22222C0 1.17444 -3.13709e-08 0.651111 0.308421 0.325556C0.616842 -3.31137e-08 1.11263 0 2.10526 0H7.36842C7.80632 0 8.14632 -2.79397e-08 8.42316 0.015C7.84373 0.0828273 7.30835 0.37385 6.91953 0.832354C6.5307 1.29086 6.31574 1.88463 6.31579 2.5V4.44444L6.26368 9.98167L4.73684 9.44444L3.15789 10L1.57895 9.44444L0 10ZM10 4.44444H7.36842V2.5C7.36842 2.13164 7.50705 1.77837 7.75381 1.51791C8.00057 1.25744 8.33524 1.11111 8.68421 1.11111C9.03318 1.11111 9.36786 1.25744 9.61461 1.51791C9.86137 1.77837 10 2.13164 10 2.5V4.44444ZM1.05263 2.22222C1.05263 2.07488 1.10808 1.93357 1.20679 1.82939C1.30549 1.7252 1.43936 1.66667 1.57895 1.66667H4.73684C4.87643 1.66667 5.0103 1.7252 5.109 1.82939C5.20771 1.93357 5.26316 2.07488 5.26316 2.22222C5.26316 2.36956 5.20771 2.51087 5.109 2.61506C5.0103 2.71925 4.87643 2.77778 4.73684 2.77778H1.57895C1.43936 2.77778 1.30549 2.71925 1.20679 2.61506C1.10808 2.51087 1.05263 2.36956 1.05263 2.22222ZM1.05263 4.44444C1.05263 4.2971 1.10808 4.15579 1.20679 4.05161C1.30549 3.94742 1.43936 3.88889 1.57895 3.88889H2.63158C2.77117 3.88889 2.90504 3.94742 3.00374 4.05161C3.10244 4.15579 3.15789 4.2971 3.15789 4.44444C3.15789 4.59179 3.10244 4.73309 3.00374 4.83728C2.90504 4.94147 2.77117 5 2.63158 5H1.57895C1.43936 5 1.30549 4.94147 1.20679 4.83728C1.10808 4.73309 1.05263 4.59179 1.05263 4.44444ZM1.05263 6.66667C1.05263 6.51932 1.10808 6.37802 1.20679 6.27383C1.30549 6.16964 1.43936 6.11111 1.57895 6.11111H3.68421C3.8238 6.11111 3.95767 6.16964 4.05637 6.27383C4.15508 6.37802 4.21053 6.51932 4.21053 6.66667C4.21053 6.81401 4.15508 6.95532 4.05637 7.0595C3.95767 7.16369 3.8238 7.22222 3.68421 7.22222H1.57895C1.43936 7.22222 1.30549 7.16369 1.20679 7.0595C1.10808 6.95532 1.05263 6.81401 1.05263 6.66667Z"
                    fill="white"
                    fill-opacity="0.25"
                  />
                </svg>

                <h1 className="text-white/40 text-sm font-normal">
                  Faturas e multas
                </h1>
              </div>

              <div className="flex items-center justify-between w-full border border-white/[.06] rounded bg-white/[.02] p-6">
                <div className="flex flex-col items-start">
                  <span className="text-white/50 text-xs font-normal">
                    Faturas pendentes
                  </span>

                  <h1 className="text-white text-xl font-medium">$ 0</h1>
                </div>
                <svg
                  width="2.625rem"
                  height="2.6875rem"
                  viewBox="0 0 42 43"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    y="0.5"
                    width="42"
                    height="42"
                    rx="8"
                    fill="#B38A5B"
                    fill-opacity="0.06"
                  />
                  <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M13 29.5V17.0556C13 15.3791 13 14.5418 13.4935 14.0209C13.9869 13.5 14.7802 13.5 16.3684 13.5H24.7895C25.4901 13.5 26.0341 13.5 26.4771 13.524C25.55 13.6325 24.6934 14.0982 24.0712 14.8318C23.4491 15.5654 23.1052 16.5154 23.1053 17.5V20.6111L23.0219 29.4707L20.5789 28.6111L18.0526 29.5L15.5263 28.6111L13 29.5ZM29 20.6111H24.7895V17.5C24.7895 16.9106 25.0113 16.3454 25.4061 15.9287C25.8009 15.5119 26.3364 15.2778 26.8947 15.2778C27.4531 15.2778 27.9886 15.5119 28.3834 15.9287C28.7782 16.3454 29 16.9106 29 17.5V20.6111ZM14.6842 17.0556C14.6842 16.8198 14.7729 16.5937 14.9309 16.427C15.0888 16.2603 15.303 16.1667 15.5263 16.1667H20.5789C20.8023 16.1667 21.0165 16.2603 21.1744 16.427C21.3323 16.5937 21.4211 16.8198 21.4211 17.0556C21.4211 17.2913 21.3323 17.5174 21.1744 17.6841C21.0165 17.8508 20.8023 17.9444 20.5789 17.9444H15.5263C15.303 17.9444 15.0888 17.8508 14.9309 17.6841C14.7729 17.5174 14.6842 17.2913 14.6842 17.0556ZM14.6842 20.6111C14.6842 20.3754 14.7729 20.1493 14.9309 19.9826C15.0888 19.8159 15.303 19.7222 15.5263 19.7222H17.2105C17.4339 19.7222 17.6481 19.8159 17.806 19.9826C17.9639 20.1493 18.0526 20.3754 18.0526 20.6111C18.0526 20.8469 17.9639 21.073 17.806 21.2397C17.6481 21.4063 17.4339 21.5 17.2105 21.5H15.5263C15.303 21.5 15.0888 21.4063 14.9309 21.2397C14.7729 21.073 14.6842 20.8469 14.6842 20.6111ZM14.6842 24.1667C14.6842 23.9309 14.7729 23.7048 14.9309 23.5381C15.0888 23.3714 15.303 23.2778 15.5263 23.2778H18.8947C19.1181 23.2778 19.3323 23.3714 19.4902 23.5381C19.6481 23.7048 19.7368 23.9309 19.7368 24.1667C19.7368 24.4024 19.6481 24.6285 19.4902 24.7952C19.3323 24.9619 19.1181 25.0556 18.8947 25.0556H15.5263C15.303 25.0556 15.0888 24.9619 14.9309 24.7952C14.7729 24.6285 14.6842 24.4024 14.6842 24.1667Z"
                    fill="#B38A5B"
                  />
                </svg>
              </div>

              <div className="flex items-center justify-between w-full mt-2 border border-white/[.06] rounded bg-white/[.02] p-6">
                <div className="flex flex-col items-start">
                  <span className="text-white/50 text-xs font-normal">
                    Multas pendentes
                  </span>

                  <h1 className="text-white text-xl font-medium">$ 0</h1>
                </div>
                <svg
                  width="2.625rem"
                  height="2.6875rem"
                  viewBox="0 0 42 43"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <rect
                    y="0.5"
                    width="42"
                    height="42"
                    rx="8"
                    fill="#B35B5D"
                    fill-opacity="0.06"
                  />
                  <path
                    d="M19.7415 14.7642C19.8674 14.5322 20.0502 14.3393 20.2712 14.205C20.4922 14.0707 20.7434 14 20.9992 14C21.255 14 21.5062 14.0707 21.7272 14.205C21.9482 14.3393 22.131 14.5322 22.2569 14.7642L28.8045 26.7132C29.3614 27.7299 28.6621 29 27.5452 29H14.4548C13.3379 29 12.6386 27.7299 13.1955 26.7132L19.7415 14.7642ZM20.1991 19.8328V21.4996C20.1991 21.7206 20.2834 21.9326 20.4335 22.0888C20.5835 22.2451 20.787 22.3329 20.9992 22.3329C21.2114 22.3329 21.4149 22.2451 21.5649 22.0888C21.715 21.9326 21.7993 21.7206 21.7993 21.4996V19.8328C21.7993 19.6118 21.715 19.3998 21.5649 19.2435C21.4149 19.0872 21.2114 18.9994 20.9992 18.9994C20.787 18.9994 20.5835 19.0872 20.4335 19.2435C20.2834 19.3998 20.1991 19.6118 20.1991 19.8328ZM20.9992 23.583C20.6809 23.583 20.3757 23.7147 20.1506 23.9491C19.9256 24.1836 19.7991 24.5015 19.7991 24.8331C19.7991 25.1646 19.9256 25.4826 20.1506 25.717C20.3757 25.9515 20.6809 26.0832 20.9992 26.0832C21.3175 26.0832 21.6227 25.9515 21.8478 25.717C22.0728 25.4826 22.1993 25.1646 22.1993 24.8331C22.1993 24.5015 22.0728 24.1836 21.8478 23.9491C21.6227 23.7147 21.3175 23.583 20.9992 23.583Z"
                    fill="#B35B5D"
                  />
                </svg>
              </div>
            </div>

            <CustomBalanceChart className="w-[46rem]" />
          </div>

          <div className="flex items-start justify-center gap-4">
            <TransactionTable className="w-[51.875rem]" />
            <QuickActions
              className="w-[19.125rem]"
              onDeposit={handleDeposit}
              onWithdraw={handleWithdraw}
            />
          </div>
        </div>
      </motion.div>
    </>
  );
}
