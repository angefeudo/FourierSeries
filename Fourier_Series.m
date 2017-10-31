% ***********************************************************************%
% Title : Fourier Series of Periodic Function (Signal)
% Description : Periodic Signal can be represented by the sum of their sine
%                and cosine coefficient value known as a Fourier Sreies
%               (Fourier Expansion)
% Writtne by : Angelo F. Fiestada
% Yr & Sec : BSCS 4-4
%************************************************************************%



%***************Function MP3_FiestadaA (MAIn)*****************************%
function Fourier_Series
fprintf('\n\t\t***********************************************');
fprintf('\n\t\t*            Function 1                       *');
fprintf('\n\t\t*            Function 2                       *');
fprintf('\n\t\t*            Function 3                       *');
fprintf('\n\t\t*            Function 4                       *');
fprintf('\n\t\t*            Function 5                       *');
fprintf('\n\t\t***********************************************\n');

prompt = '        Select a Function:  =>';

funct = input(prompt);

prompt = '        Enter the desired umber of Coefficient: =>';


coefnum = input(prompt);

    switch funct
        case 1

            signal = {@(x)sin(x), 0, pi, .5, pi, 2*pi};        
            series = getFSeries(signal,coefnum);
            printCoef(series,coefnum);
            showsignal(series, coefnum);

        case 2
            signal = {@(x)x^2, -pi, pi, -1, -1, -1};        
            series = getFSeries(signal,coefnum);
            printCoef(series,coefnum);
            showsignal(series, coefnum);

        case 3
            signal = {@(x)-x+1, 0, pi, 0, pi, 2*pi};        
            series = getFSeries(signal,coefnum);
            printCoef(series,coefnum);
            showsignal(series, coefnum);
        case 4

            signal = {@(x)x, 0, pi, pi, pi, 2*pi};        
            series = getFSeries(signal,coefnum);
            printCoef(series,coefnum);
            showsignal(series, coefnum);
            
        case 5

            signal = {@(x)x, 0, pi, -1, pi, 2*pi};        
            series = getFSeries(signal,coefnum);
            printCoef(series,coefnum);
            showsignal(series, coefnum);
    otherwise
        fprintf('Invalid Input');

    end
end 
%****************End MP3_FiestadaA*****************************************%
    
    
    %***************Function printCoef******************%
    function printCoef(series,coefnum)
       n = 1;
       fprintf('\t\tThe Coeffiecient are: ');
        for index = 1:1:coefnum;
            
            fprintf('\n\t\tC%d\t %.3f', index-1, series(n));
            n = n +1;
        end
    end
    %***************END Function printCoef******************%
    

    %*****************Function showSignal*********************%
    function showsignal(series, coefnum)
        
        p = coefnum;
        Freq = 1/p;
        T = 1/Freq;
        t = 0:0.1:T;
        d = t(2)-t(1);
        sp = [series, series, series, series];
        t = (1:length(sp))*d;
        
        subplot(2,1,1);
        plot(t, sp);
        grid on;
        subplot(2,1,2);
        stem(series);
        grid on;

    
    end
    
     %***************END Function showSiganl******************%


    %***************Function gegSeriesValue*******************%
    
    function fseries = getFSeries(signal, number)
        
        sig = signal;
        n = number;
        coef = zeros(1,n);
        
        for index = 1:1:n
            if index == 1
                coef(index) = getA0Value(sig);
            else
                coef(index) = getAnValue(sig, index)...
                            + getBnValue(sig, index);
               
            end
       
        end
        
        fseries = coef;
        
    end
   
     %***************END Function gegSeriesValue****************%

 %***************Function getAnValue***************************%
    function anvalue = getAnValue(sig, index)
        
        if sig{4} == -1
            x = sym('x');
            n = index;
             f1 = sig{1};
            baseperiod = 1/pi;
            strtpt = sig{2};
            frequency = sig{3};
            approxarea = baseperiod*int(f1*cos(n*x),x,strtpt,frequency);
             anvalue = approxarea;
        else
            
             x = sym('x');
            n = index;
            baseperiod = 1/pi;

            strtpt = sig{2};
            frequency = sig{5};
            period = sig{6};

            f1 = sig{1};
            f2 = @(x)sig{4}*ones(size(x));

      
            approxarea = baseperiod*int(f1*cos(n*x),x,strtpt,frequency)...
            + baseperiod*int(f2*cos(n*x), x, frequency, period);
        anvalue =approxarea;
            
            
        end
        
    end
      %***************END Function gegAnValue*******************%


%***************Function getBnValue*****************************%
% get the the cosine Coefficient of the signal given the period T
%    from bn = 1 up to n
    function bnvalue = getBnValue(sig, index)
        
        
        if sig{4} == -1
            x = sym('x');
            n = index;
             f1 = sig{1};
            baseperiod = 1/pi;
            strtpt = sig{2};
            frequency = sig{3};
            approxarea = baseperiod*int(f1*sin(n*x),x,strtpt,frequency);
             bnvalue = approxarea;
        else
            
             x = sym('x');
            n = index;
            baseperiod = 1/pi;

            strtpt = sig{2};
            frequency = sig{5};
            period = sig{6};

            f1 = sig{1};
            f2 = @(x)sig{4}*ones(size(x));

      
            approxarea = baseperiod*int(f1*sin(n*x),x,strtpt,frequency)...
            + baseperiod*int(f2*sin(n*x), x, frequency, period);
        bnvalue =approxarea;
            
            
        end
       
    end
   %***************END Function gegSeriesValue*******************%



%***************Function getA0Value********************************%
% Get the  coefficient of the signal at a = 0 given the period T 
%   from an = 1 up to n
    function a0value = getA0Value(sig)
        
       if sig{4} == -1
            x = sym('x');
             f1 = sig{1};
            baseperiod = 1/pi;
            strtpt = sig{2};
            frequency = sig{3};
            approxarea = baseperiod*int(f1,x,strtpt,frequency);
             a0value = approxarea/2;
        else
            
             x = sym('x');
            baseperiod = 1/pi;

            strtpt = sig{2};
            frequency = sig{5};
            period = sig{6};

            f1 = sig{1};
            f2 = @(x)sig{4}*ones(size(x));

      
            approxarea = baseperiod*int(f1,x,strtpt,frequency)...
            + baseperiod*int(f2, x, frequency, period);
            a0value =approxarea/2;
            
            
        end
        
    end
     %***************END Function getA0SeriesValue*******************%