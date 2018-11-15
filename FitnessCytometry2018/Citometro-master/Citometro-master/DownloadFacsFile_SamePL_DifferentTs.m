%% DESCARGA LOS DATOS DE UN SOLO PLATO
clear
cd 'C:\Users\JAbraham\Dropbox\PhD\Experimentos (ExMonth15)\EMMayJun16\Folder_001\Experiment_008\' %Ponerse en el folder que tiene los Fcs
platos=dir('*PL1*'); %Nombre del plato que se quiera extraer
plato=4;
length(platos)
for i=1:length(platos)
    x=tic; i %para saber cuanto lleva
    cd (platos(i).name);
    wells=dir;
    if i==1 %selecciona los campos de la info que no son utiles
        j=1;
        [datos info] = fca_readfcs(wells(j+2).name); %aunque datosEscalados no se guarda porque no sabemos ni qu'e con ellos todav'ia
        campos = fieldnames(info);
        FieldsToDelete = campos([1 3 9 13 15 16 17:end])
    end
    for j=1:length(wells)-2
        [datos info ] = fca_readfcs(wells(j+2).name); %aunque datosEscalados no se guarda porque no sabemos ni qu'e con ellos todav'ia
        if ~isempty(datos)%porque salio un archivo que "no es de tipo fcs soportado" whatever that means
        info=rmfield(info, FieldsToDelete);
        well = str2num(str2mat(info.filename(end-6:end-4)));
        PL(i).WELL(well).dat = datos;
        PL(i).WELL(well).info = info;
        else
            PL(i).WELL(well+1).info.filename=0;
        end
    end
    cd ..
    toc(x)
end