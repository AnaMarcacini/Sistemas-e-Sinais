%% Resposta impulsiva e propriedadesclear all;clc;close all;pkg load symbolic;        % Somente para os que usam                           % Octave%% Definindo o sinal a ser estudado%% Ona pulsada de dois níveis, período To e largura tau A1 = 1;                  % Amplitude em nível alto A2 = 0;                  % Amplitude em nível baixo tau1 = 0.5;              % Duração em nível alto tau2 = 0.005;            % Duração em nível alto To1 = 1;                 % Período primeiro pulso - To = 1 s --> fo = 1Hz  To2 = 100;               % Período segundo pulso  %%% Valores calculados para o primeio pulso fo1 = inv(To1);          % frequência em Hz --> fo  = 1Hz wo1 = 2*pi*fo1;          % frequência angular N1 = 10;                 % Número de harmônicas da análise                          % -10Hz --> 10Hz - escolha n=[-N1:1:N1];            % índice de cada harmônica f1 = n*fo1;              % vetor de frequências da análise de Fourier%%% Vetor tempo para visualização do sinal%%% diferente da variável simbólica t%%% para efeito de organização da solução%%% existem outros caminhos M = 1000; Ts1 = To1/M; tempo1 = [0:Ts1:100*To1];  % Tempo de simulação de um período do sinal g(t)  %%% Valores calculados para o segundo pulso fo2 = inv(To2);          % frequência em Hz --> fo = 0.1Hz wo2 = 2*pi*fo2;          % frequência angular N2 = 1000;               % Número de harmônicas da análise --> N = 10/fo                          % -10Hz --> 10Hz n=[-N2:1:N2];            % índice de cada harmônica f2 = n*fo2;              % vetor de frequências da análise de Fourier%%% Vetor tempo para visualização do sinal%%% diferente da variável simbólica t%%% para efeito de organização da solução%%% existem outros caminhos Ts2 = To2/M; tempo2 = [0:Ts2:1*To2];            % Tempo de simulação de um período do sinal g(t)  %% Determinando o termo Dn simbolicamente% n simbólicosyms n tDn1 = inv(To1)*int(A1*exp(-j*n*wo1*t),t,0,tau1) + inv(To1)*int(A2*exp(-j*n*wo1*t),t,tau1,To1);D_o1 = inv(To1)*int(A1,t,0,tau1) + inv(To1)*int(A2,t,tau1,To1);Dn2 = inv(To2)*int(A1*exp(-j*n*wo2*t),t,0,tau2) + inv(To2)*int(A2*exp(-j*n*wo2*t),t,tau2,To2);D_o2 = inv(To2)*int(A1,t,0,tau2) + inv(To2)*int(A2,t,tau2,To2);%% Determinando o termo Dn numericamenten=[-N1:1:N1]; Dn1 = eval(Dn1);D_o1 = eval(D_o1) ;      % Corrigindo o valor médio (NaN devido a indeterminação)Dn1(N1+1) = D_o1 ;       % Subistituindo no vetor de respostasn=[-N2:1:N2];Dn2 = eval(Dn2);D_o2 = eval(D_o2);       % Corrigindo o valor médio (NaN devido a indeterminação)Dn2(N2+1) = D_o2;        % Subistituindo no vetor de respostas%% Sabe-se da teoria que Dn%% sinc (X)%% Compute the sinc function.%% Return sin (pi*x) / (pi*x).Dn =  @(A1,tau1,f)  sinc(2*f*tau1/2)%% Visualizando o espector de Amplitude figure(1) subplot(2,1,1); plot(f1,abs(Dn1),'ko'); hold;plot(f1,abs(0.5*Dn(A1,tau1,f1)),'k-.')title('Serie de Fourier do sinal g(t) -- To = 1s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')subplot(2,1,2); plot(f2,abs(Dn2),'ko'); title('Serie de Fourier do sinal g(t)  -- To = 10s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')%% Sintetizando o primeiro sinaln=[-N1:1:N1];n1 =n;aux  = 0;             for k = 0 : 2*N1          aux = aux + Dn1(k+1)*exp(j*n1(k+1)*wo1*tempo1);  endgr1 = aux;%% Sintetizando o segundo sinaln=[-N2:1:N2];n2 = n;aux  = 0;             for k = 0 : 2*N2          aux = aux + Dn2(k+1)*exp(j*n2(k+1)*wo2*tempo2);  endgr2 = aux;%% Sintetizando o terceiro sinalfigure(2)subplot(2,1,1); plot(tempo1,gr1); title('Serie de Fourier do sinal g(t) To = 1s');xlabel('Tempo em segundos');ylabel('Amplitude em  volts')subplot(2,1,2); plot(tempo2,gr2);title('Serie de Fourier do sinal g(t) To = 10s');xlabel('tempo em segundos');ylabel('Amplitude em  volts')
