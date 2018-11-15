function [BgDataAll] = LoadCytFiles(Reader)
% Descarga los .fcs que esten en la carpeta actual en una sola estructura
% Reader = 1 usar el lector viejito que sacamos del github de MSpringer lab
% si no dice nada, entonces usa el fca_readfcs que es que que ya usabamos
%
% Funciones que necesita:
% fca_readfcs % que lee los archivos del citometro nuevo
% fcsread % From MikeSpringerLab github que lee los archivos de citometro viejo

tubos=dir('*.fcs*'); %Nombre del plato que se quiera extraer

if nargin<1 
    Reader=1;
end



for i=1:length(tubos)
   % i/length(tubos) %para saber cuanto lleva
    
%     if i==1 %selecciona los campos de la info que no son utiles
%         j=1;
%         [datos info] = fca_readfcs(wells(j+2).name); %aunque datosEscalados no se guarda porque no sabemos ni qu'e con ellos todav'ia
%         campos = fieldnames(info);
%         FieldsToDelete = campos([1 3 9 13 15 16 17:end])
%     end
    if Reader
        [datos info] = fca_readfcs(tubos(i).name); %aunque datosEscalados no se guarda porque no sabemos ni qu'e con ellos todav'ia
        if ~isempty(datos)%porque salio un archivo que "no es de tipo fcs soportado" whatever that means
            %info=rmfield(info, FieldsToDelete);
            BgDataAll(i).dat = datos;
            BgDataAll(i).info = info;
        else
            BgDataAll(i).info.filename=0;
        end
    else
        [datos, info, metad]=fcsread(tubos(i).name);
        BgDataAll(i).dat = datos(1:size(datos),:);
        BgDataAll(i).info= info;
        BgDataAll(i).meta= metad;
        BgDataAll(i).filename=tubos(i).name;
    end

end

end

