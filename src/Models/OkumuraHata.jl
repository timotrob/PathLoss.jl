

@doc """OKUMURA-HATA URBAN model
 #  freq: signal frequency(500Mhz e 1500Mhz);
 #  tyArea: area type (1-rural, 2-suburban e 3-urban);
 #  areaKind : cyte type (1-small, 2-medium e 3-large);
 #  hb: base station's height;
 #  hm: mobile's height;
"""
type OkumuraHataModel<:Model
  freq::Float64
  txH::Float64
  rxH::Float64
  cityKind::Int
  areaKind::Int
  OkumuraHataModel() = new(800,50,1.5,CityKind.Medium,AreaKind.Urban)
end

@doc "Calculate the path loss with the Okumura-Hata Model"
function pathloss_op(model::OkumuraHataModel,dist::AbstractFloat,checkFreqRange=true)
    # frequency
   f::Float64  = model.freq;
   # Checking the frequency range
   if (checkFreqRange)
     if (f < 500 || f > 1500)
      error("The frequency range for OkumuraHata is 500MHz-1500Mhz")
     end
   end
   #Bts and MS Heights
   Hm::Float64 = model.rxH
   Hb::Float64 = model.txH

   cityKind::Int = model.cityKind
   areaKind::Int = model.areaKind
          #a(hm) from  hata model, hm = altura móvel
          a::Float64=0.0;
          if (f <= 200 && cityKind==CityKind.Large)
                # Large cities and f<=200 Mhz
                a = 8.29*(log10(1.54*Hm))^2- 1.1;

          elseif (f>=400 && cityKind==CityKind.Large)
               #Large cities and f>= 400 MHz
                a = 3.2*((Math.log10(11.75*Hm)^2))- 4.97;
          else
              #a(hm) for small and medium cities, and large cities where f<200Mhz and f>400Mhz
               a = (1.1*log10(f-0.7))*Hm - (1.56*log10(f-0.8));
          end
         # Path loos for urban area
           lossUrban::Float64 = 69.55 + (26.16)*log10(f)-13.82*log10(Hb) - a + (44.9-6.55*log10(Hb))*log10(dist);
          if (areaKind== AreaKind.Open)
            lossOpen::Float64 = lossUrban - 4.78 *((log10(f))^2)+18.33*log10(f)-40.94;
            return lossOpen;
          elseif (areaKind==AreaKind.SubUrban)
              #Loss for open are
              lossSubUrban::Float64 =  lossUrban  - 2*(log10(f/28.0))^2 - 5.4# //#Loss for suburban area
              return lossSubUrban;
          end
          return lossUrban;
end
