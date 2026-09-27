import React from "react";

const SidebarIcon: React.FC<React.SVGProps<SVGSVGElement>> = (props) => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width="4.4375rem"
    height="4.25rem"
    viewBox="0 0 71 68"
    fill="none"
    {...props}
  >
    <g filter="url(#filter0_d_75_5590)">
      <path
        d="M40.0768 32.8135C39.0486 32.9916 37.9548 32.6799 37.1599 31.8709L35.7707 30.457C35.2238 29.9004 34.9175 29.1508 34.9175 28.3641V27.915L32.0115 26.3008C31.8183 26.1932 31.698 25.9816 31.7089 25.7553C31.7199 25.5289 31.8511 25.3285 32.0553 25.2357L33.7763 24.4564C34.4472 24.1559 35.1728 24 35.9093 24H36.5692C37.9074 24 39.1945 24.5195 40.168 25.451L41.7942 27.0096C42.6765 27.8557 43.0047 29.0766 42.764 30.201L43.3401 30.791L43.6318 30.4941C43.9746 30.1453 44.5288 30.1453 44.8679 30.4941L45.7429 31.3848C46.0857 31.7336 46.0857 32.2977 45.7429 32.6428L42.5343 35.9084C42.1916 36.2572 41.6374 36.2572 41.2983 35.9084L40.4232 35.0178C40.0805 34.6689 40.0805 34.1049 40.4232 33.7598L40.7149 33.4629L40.0768 32.8135ZM25.999 37.9939L34.5128 30.7762C34.6404 30.958 34.7863 31.1324 34.9431 31.2957L36.3322 32.7096C36.551 32.9322 36.7844 33.1252 37.0323 33.2922L29.9187 41.9832C29.39 42.6289 28.606 43 27.782 43C26.2433 43 25 41.7309 25 40.1686C25 39.3299 25.3683 38.532 25.999 37.9939Z"
        fill="white"
      />
    </g>
    <defs>
      <filter
        id="filter0_d_75_5590"
        x="0"
        y="-1"
        width="71"
        height="69"
        filterUnits="userSpaceOnUse"
        colorInterpolationFilters="sRGB"
      >
        <feFlood floodOpacity="0" result="BackgroundImageFix" />
        <feColorMatrix
          in="SourceAlpha"
          type="matrix"
          values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
          result="hardAlpha"
        />
        <feOffset />
        <feGaussianBlur stdDeviation="12.5" />
        <feComposite in2="hardAlpha" operator="out" />
        <feColorMatrix
          type="matrix"
          values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.5 0"
        />
        <feBlend
          mode="normal"
          in2="BackgroundImageFix"
          result="effect1_dropShadow_75_5590"
        />
        <feBlend
          mode="normal"
          in="SourceGraphic"
          in2="effect1_dropShadow_75_5590"
          result="shape"
        />
      </filter>
    </defs>
  </svg>
);

export default SidebarIcon;
