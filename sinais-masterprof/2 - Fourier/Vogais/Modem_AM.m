%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0 - Boas práticasclear all;clc;close all;pkg load symbolic;                       % Somente para os que usam                                          % Octave%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 - Mensagem%% Am  = 1;                  % amplitude da mensagemfm  = 1;                  % frequência da mensagem em Hzwm  = 2*pi*fm;            % frequência angular ad mensagemTm  = 1/fm;               % período de amostragem%%% Definir o vetor tempoNp    = 3;Npp   = 1000;tempo = linspace(0,Np*Tm,Npp*Np);%%% Mensagemmt = Am * cos(wm*tempo);%%% Visualizar a mensagemfigure(1)plot(tempo, mt, 'linewidth',3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 - Portadora%% Ac  = 1;                  % amplitude da mensagemfc  = 10;                 % frequência da mensagem em Hzwc  = 2*pi*fc;            % frequência angular ad mensagemTc  = 1/fc;               % período de amostragem%%% Portadoraec = Ac * cos(wc*tempo);%%% Visualizar a portadorafigure(2)plot(tempo, ec,'linewidth',3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3 - Modulação AM%% AM = mt.*ec;              % sinal modulado - produto%%% Visualizar o sinal moduladofigure(3)plot(tempo, AM,'linewidth',3); hold; plot(tempo, mt,'linewidth',3, 'g-.')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4 - Sincronismo%% %%% Portadora localtheta = pi/2; ecl   = Ac * cos(wc*tempo + theta);%%% Demodulaçãomr    = AM.*ecl;figure(4)plot(tempo, mr,'linewidth',3); hold; plot(tempo, mt,'linewidth',3, 'g-.')%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 5 - Adicionando nível médio%% Nm = 2;                 % adiciona 1 no nível médiomt = mt + Nm;           % modifico a mensagemAM = mt.*ec;            % sinal moduladoAMfigure(5)plot(tempo, AM,'linewidth',3); hold; plot(tempo, mt,'linewidth',3, 'g-.')%%% processar por um diodo o sinaldiodo      = AM > 0.7;           % implementando um diodo idealretificado = AM.*diodo;        % sinal retificadofigure(6)subplot(2,1,1); plot(tempo,AM, 'linewidth',3)subplot(2,1,2); plot(tempo,retificado, 'linewidth',3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7 - Análise no domínio da frequência%% %%% Espectros FourierAM = fftshift(fft(AM));FourierRT = fftshift(fft(retificado));%%% construindo o eixo frequência%% Np    = 3;%% Npp   = 1000;%% tempo = linspace(0,Np*Tm,Npp*Np);Ts   = Tc/Npp;fs   = 0.1/Ts;freq = linspace(-fs/2,fs/2,length(AM));figure(7)subplot(2,1,1); plot(freq, abs(FourierAM), 'linewidth',3)subplot(2,1,2); plot(freq, abs(FourierRT), 'linewidth',3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 8 - Projeto do filtro%% fcorte = 1.5;         % frequência de corte em Hzwcorte = 2*pi*fcorte; % frequência angular de corteRC     = 1/wcorte;    % Constante de tempo RCFPB    = @(w,RC)      1./(j*w*RC+1)%%% Aplicando o filtro - frequênciaMr_Fourier = FPB(2*pi*freq,RC).*FPB(2*pi*freq,RC).*FPB(2*pi*freq,RC).*FourierRT;%%% Voltando ao domínio do tempomrecuperada = ifft(fftshift(Mr_Fourier));figure(8)subplot(2,1,1); plot(tempo,mt, 'linewidth',3)subplot(2,1,2); plot(tempo,mrecuperada, 'linewidth',3)figure(9)subplot(2,1,1); plot(freq, abs(FourierAM)/max(abs(FourierAM)), 'linewidth',3);hold; plot(freq, abs(FPB(2*pi*freq,RC).*FPB(2*pi*freq,RC).*FPB(2*pi*freq,RC)), 'linewidth',3)subplot(2,1,2); plot(freq, abs(FourierRT)/max(abs(FourierRT)), 'linewidth',3);hold; plot(freq, abs(FPB(2*pi*freq,RC).*FPB(2*pi*freq,RC).*FPB(2*pi*freq,RC)), 'linewidth',3)