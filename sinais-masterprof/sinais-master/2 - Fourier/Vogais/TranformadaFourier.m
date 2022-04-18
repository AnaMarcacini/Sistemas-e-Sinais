%% Tranformada de Fourierclear all;clc;close all;pkg load symbolic;                                    % Somente para os que usam                                                       % Octave%% Definindo o sinal a ser estudado%% Ona pulsada de dois níveis, período To e largura tau A1 = 1;                  % Amplitude em nível alto A2 = 0;                  % Amplitude em nível baixo tau = 1.0;               % Largura do pulso de teste To1 = 100;               %   To2 = 100;               %  To3 = 100;               % Período terceiro pulso --> tender a infinito  %%% Modificações - deslocamento  atraso1 = 1.5             % atraso de 1.5 segundos atraso2 = 0.5             % atraso de 0.5 segundo %%% Valores calculados para o primeio pulso fo1 = inv(To1);            % frequência em Hz --> fo  = 1Hz wo1 = 2*pi*fo1;            % frequência angular N1 = 1000;                   % Número de harmônicas da análise                            % -10Hz --> 10Hz - escolha n=[-N1:1:N1];              % índice de cada harmônica f1 = n*fo1;                % vetor de frequências da análise de Fourier%%% Vetor tempo para visualização do sinal%%% diferente da variável simbólica t%%% para efeito de organização da solução%%% existem outros caminhos M = 1000; Ts1 = To1/M; tempo1 = [-To1/2:Ts1:To1/2];  % Tempo de simulação de um período do sinal g(t)  %%% Valores calculados para o segundo pulso fo2 = inv(To2);            % frequência em Hz --> fo = 0.1Hz wo2 = 2*pi*fo2;            % frequência angular N2 = 1000;                  % Número de harmônicas da análise --> N = 10/fo                            % -10Hz --> 10Hz n=[-N2:1:N2];              % índice de cada harmônica f2 = n*fo2;                % vetor de frequências da análise de Fourier%%% Vetor tempo para visualização do sinal%%% diferente da variável simbólica t%%% para efeito de organização da solução%%% existem outros caminhos Ts2 = To2/M; tempo2 = [-To2/2:Ts2:To2/2];            % Tempo de simulação de um período do sinal g(t)  %%% Valores calculados para o terceiro pulso fo3 = inv(To3);            % frequência em Hz fo  -> 0.01Hz wo3 = 2*pi*fo3;            % frequência angular N3 = 1000;                 % Número de harmônicas da análise                            % -10Hz --> 10Hz n=[-N3:1:N3];              % índice de cada harmônica f3 = n*fo3;                % vetor de frequências da análise de Fourier%%% Vetor tempo para visualização do sinal%%% diferente da variável simbólica t%%% para efeito de organização da solução%%% existem outros caminhos Ts3 = To3/M; tempo3 = [-To3/2:Ts3:To3/2];            % Tempo de simulação de um período do sinal g(t)  %% Determinando o termo Dn simbolicamente% n simbólicosyms n t%%%% Será o meu pulso de baseDn1 = inv(To1)*int(A1*exp(-j*n*wo1*t),t,-tau/2,tau/2);D_o1 = inv(To1)*int(A1,t,-tau/2,tau/2);%% Determinando o termo Dn numericamenten=[-N1:1:N1]; Dn1 = eval(Dn1);D_o1 = eval(D_o1) ;     % Corrigindo o valor médio (NaN devido a indeterminação)Dn1(N1+1) = D_o1 ;       % Subistituindo no vetor de respostas%% Visualizando o espector de Amplitude figure(1) plot(f1,abs(Dn1),'ko');title('Serie de Fourier do sinal g(t) -- To = 1s');xlabel('Frequencia em Hz');ylabel('Amplitude em  volts')%% Sintetizando o primeiro sinaln=[-N1:1:N1];n1 =n;aux  = 0;             for k = 0 : 2*N1          aux = aux + Dn1(k+1)*exp(j*n1(k+1)*wo1*tempo1).*exp(-j*n1(k+1)*wo2*atraso2);  endgr1 = aux;%% Sintetizando o segundo sinaln=[-N2:1:N2];n2 = n;aux  = 0;             for k = 0 : 2*N2          aux = aux + Dn1(k+1)*exp(j*n2(k+1)*wo2*tempo2).*exp(-j*n2(k+1)*wo2*atraso1);  endgr2 = 2 * aux;%% Sintetizando o terceiro sinaln=[-N3:1:N3];n3 =n;aux  = 0;             for k = 0 : 2*N3          aux = aux + Dn1(k+1)*exp(j*n3(k+1)*wo3*tempo3).*exp(j*n2(k+1)*wo2*atraso1);  endgr3 = 2 * aux;n=[-N1:1:N1];n1 =n;aux  = 0;             for k = 0 : 2*N1          aux = aux + Dn1(k+1)*exp(j*n1(k+1)*wo1*tempo1).*exp(+j*n2(k+1)*wo2*atraso2);  endgr4 = aux;figure(2)plot(tempo1,gr1+gr2+gr3+gr4, 'linewidth',3); title('Serie de Fourier do sinal g(t) To = 100s');xlabel('Tempo em segundos');ylabel('Amplitude em  volts')

