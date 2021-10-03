clc,clear all,close all
%creating a signal with three frequencies
dt=.001;
t=0:dt:1;
fclean=sin(2*pi*50*t)+sin(2*pi*120*t)+sin(2*pi*150*t);%sum of three frequencies
f=fclean+2.5*randn(size(t));%adding some noise
subplot(3,1,1)
plot(t,f,'c','LineWidth',3),hold on
plot(t,fclean,'Color',[.5 .1 0],'LineWidth',2.5)
xlabel('Time');
ylabel('Original signal');
title('Signal Plot');
l1=legend('Noisy','Clean');set(l1,'FontSize',12)
ylim([-10 10]); set(gca,'FontSize',12)
%%Computing the Fast Fourier Transform (FFT)
n=length(t);
fhat=fft(f,n);%Compute the fast fourier transform
PSD=fhat.*conj(fhat)/n;%Power spectrum calculation(power per frequency)
freq=1/(dt*n)*(0:n);%Create x-axis of frequencies in Hz
L=1:floor(n/2);%Only plot the first half of frequencies

subplot(3,1,2);set(gca,'FontSize',12)
plot(freq(L),PSD(L),'c','LineWidth',3),hold on
set(gca,'FontSize',12)

%%Use the PSD to filter out noise
indices=PSD>100;%find all frequencies with power greater than 100
PSDclean=PSD.*indices;%this zeroes out the freqs having power less than 100
fhat=indices.*fhat;%Zero out small fourier coeffs in Y
ffilt=ifft(fhat);%Inverse FFT for filterd time signal

plot(freq(L),PSDclean(L),'-','Color',[.5 .1 0],'LineWidth',2.5)
xlabel('Frequency(Hz)');
ylabel('Power');
title('Power Spectrum');
l1=legend('Noisy','Filtered');set(l1,'FontSize',12)

subplot(3,1,3);set(gca,'FontSize',12)
plot(t,ffilt,'-','Color',[.5 .1 0],'LineWidth',2.5)
xlabel('Time');
ylabel('Filtered signal');
title('Final plot');
l1=legend('Filtered');set(l1,'FontSize',12)
ylim([-10 10]);set(gca,'FontSize',12)

