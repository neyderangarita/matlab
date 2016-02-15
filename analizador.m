function varargout = analizador(varargin)
% ANALIZADOR M-file for analizador.fig
%      ANALIZADOR, by itself, creates a new ANALIZADOR or raises the existing
%      singleton*.
%
%      H = ANALIZADOR returns the handle to a new ANALIZADOR or the handle to
%      the existing singleton*.
%
%      ANALIZADOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALIZADOR.M with the given input arguments.
%
%      ANALIZADOR('Property','Value',...) creates a new ANALIZADOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before analizador_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to analizador_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help analizador

% Last Modified by GUIDE v2.5 16-Sep-2012 02:18:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analizador_OpeningFcn, ...
                   'gui_OutputFcn',  @analizador_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before analizador is made visible.
function analizador_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to analizador (see VARARGIN)
background = imread('index.jpg'); %Leer imagen
axes(handles.axis); %Carga la imagen en background
axis off;
imshow(background); %Presenta la imagen
% Choose default command line output for evaluarte
fecha = datestr(now, 'dd/mm/yy');
%set(handles.fecha,'String',fecha);
handles.fecha = fecha;
handles.TipoPrueba = 1; 
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes analizador wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = analizador_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in sel.
function sel_Callback(hObject, eventdata, handles)
% hObject    handle to sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel
fun =get(handles.sel,'Value');
switch fun
case 1 ;
TipoPrueba=1;
case 2 ;
TipoPrueba=2; 
case 3 ;
TipoPrueba=3;
case 4 ;
TipoPrueba=4;    
case 5 ;
TipoPrueba=5;  
case 6 ;
TipoPrueba=6;  
case 7 ;
TipoPrueba=7; 
case 8 ;
TipoPrueba=8;  
case 9 ; 
TipoPrueba=9;
case 10;
TipoPrueba=10;       
end

handles.TipoPrueba = TipoPrueba;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function sel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Analizar.
function Analizar_Callback(hObject, eventdata, handles)
% hObject    handle to Analizar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.mensaje,'Visible','off');
[a pathname] = uigetfile({'*.jpg;*.jpeg','Image files(*.jpg,*.jpeg)'},'Select image files','Multiselect','on');


if(pathname)
    if (ischar(a)==1)
        imagenes{1}=imread(fullfile(pathname,a));            
    else
         for i=1:length(a)
                b=char(a(i)); %nombre imagen
                imagenes{i}=imread(fullfile(pathname,b));  
                %axes(handles.axes1); %Carga la imagen en background
                %axis off;
                %imshow(imagenes{i}); %Presenta la imagen 
         end
    end
    
    if handles.TipoPrueba == 1
%%%%%%%%%%%%%%%%PRUEBA NIVELES DE PENSAMIENTO Y ESTILO DE APRENDIZAJE%%%%%%
        handles.imagenes = imagenes;
        primeras_22 = [];
        acumulado_respuestas=[]; 
        codigo='';
        agrupar=[]; 
        CODIGOS = [];
        be= strel('line', 8, -90);
        AUX1=[];  
        
        %%%%%%%%%%%% BORRAR LOS DATOS DE Copia_Preguntas_niveles_pensamiento %%%%%%%%%%%%
        s.DataReturnFormat = 'cellarray';
        s.ErrorHandling = 'store';
        s.NullNumberRead = 'NaN';
        s.NullNumberWrite = 'NaN';
        s.NullStringRead = 'null';
        s.NullStringWrite = 'null';
        s.JDBCDataSourceFile = '';
        s.UseRegistryForSources = 'yes';
        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
        s.DefaultRowPreFetch = '10000';
        setdbprefs(s)
        conn = database('MS Access Database','','password');
        e = exec(conn,'DELETE * FROM Copia_Preguntas_niveles_pensamiento');
        e = fetch(e);
        close(e)        
        
        %%%%%%%%%%%% BORRAR LOS DATOS DE Preguntas_niveles_pensamiento %%%%%%%%%%%%
        s.DataReturnFormat = 'cellarray';
        s.ErrorHandling = 'store';
        s.NullNumberRead = 'NaN';
        s.NullNumberWrite = 'NaN';
        s.NullStringRead = 'null';
        s.NullStringWrite = 'null';
        s.JDBCDataSourceFile = '';
        s.UseRegistryForSources = 'yes';
        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
        s.DefaultRowPreFetch = '10000';
        setdbprefs(s)
        conn = database('MS Access Database','','password');
        e = exec(conn,'DELETE * FROM Preguntas_niveles_pensamiento');
        e = fetch(e);
        close(e)    
        
         
        for fotos=1:length(handles.imagenes)
         %[dilatar] = marcas(handles.imagenes{fotos});   con los cuadro
         % RECORTAMOS EL GRUPO DE PREGUNTAS EN TOTAL SON 5
         [dilatar] = marcas_niveles(handles.imagenes{fotos}); 
         
            
            for recorte=1:length(dilatar);
                     if recorte==1
                        Ne=8;   
                        Ancho_pregunta=size(dilatar{recorte},2)/Ne;
                        %Ancho_pregunta=size(dilatar{recorte},2)/Ne;
                        %Ancho_pregunta=20;
                        Alto_Pregunta=size(dilatar{recorte},1);
                        Ancho_total=size(dilatar{recorte},2);
                     elseif recorte==2  
                        Ne=16;
                        Ancho_pregunta=42;
                        Alto_Pregunta=size(dilatar{recorte},1);
                        Ancho_total=size(dilatar{recorte},2);
                     elseif recorte == 3
                        Ne=14; 
                        Ancho_pregunta=42;
                        Alto_Pregunta=size(dilatar{recorte},1); 
                        Ancho_total=size(dilatar{recorte},2);
                     else
                        Ne=22; 
                        Ancho_pregunta=size(dilatar{recorte},2)/Ne;
                        Alto_Pregunta=size(dilatar{recorte},1);
                        Ancho_total=size(dilatar{recorte},2);
                     end
                      
                for b=1:Ne  
                     %[pregunta] = recortar_columna_pregunta(columnas_preguntas ,dilatar ,recorte ,b);    
                      [pregunta] = recortar_columna_pregunta_Niveles(dilatar , b ,recorte, Alto_Pregunta, Ancho_pregunta, Ancho_total); 
                        
                      if recorte==1  
                        opciones=10;
                        [numero_respuesta] = clasificacion_niveles(pregunta,opciones,b,recorte);  
                        AUX1 = codigo;   
                        codigo = [AUX1 num2str(numero_respuesta-1)];
                          if b==8 
                              CODIGOS(fotos) = str2double(codigo);
                              codigo='';
                              break
                          end 
                      end   
                      if recorte==2  
                             opciones=3;  %cantidad de preguntas de esta seccion
                             [numero_respuesta] = clasificacion_niveles(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==16
                                 break
                             end
                      end   
                      if recorte==3 
                             opciones=3; %cantidad de preguntas de esta seccion
                             [numero_respuesta] = clasificacion_niveles(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==14
                                 break
                             end
                      end 
                      if recorte==4 
                             opciones=2; 
                             [numero_respuesta] = clasificacion_niveles(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==22
                                 break
                             end
                     end
                     if recorte==5 
                             opciones=2; 
                             [numero_respuesta] = clasificacion_niveles(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==22
                                 break
                             end
                     end     
                end   
            end
            
            primeras_22 = [];
            
            %agrupar = [agrupar ; acumulado_respuestas];
            %similar = cell(1,4); 
            for i=1:4  
                if i==1
                   dia=get(handles.dia,'String'); %Almacenar valor ingresado
                   mes=get(handles.mes,'String'); %Almacenar valor ingresado
                   ano=get(handles.ano,'String'); %Almacenar valor ingresado
                   fecha=strcat(dia,'/',mes,'/',ano);
                   similar{i}=fecha; 
                end 
                if i==2
                   Elcodigo = isnan(CODIGOS(fotos));
                   if Elcodigo==1
                    answer =inputdlg('CODIGO','Ingresa el codigo.'); 
                    similar{i} = str2double(answer{1});
                    %C{1,x} = str2double(answer{1});
                    CODIGOS = str2double(answer{1});
                   else 
                    similar{i}=CODIGOS(fotos); 
                    %C{1,1}=CODIGOS(fotos); 
                   end
                end
                if i==3
                    similar{i}=handles.TipoPrueba;  
                end  
            end
%%%%%%%%%%%%%%%%%%%%%%consultar si ya esta en la base de datos%%%%%%%%%%%%%   

            s.DataReturnFormat = 'cellarray';  
            s.ErrorHandling = 'store';
            s.NullNumberRead = 'NaN';
            s.NullNumberWrite = 'NaN';
            s.NullStringRead = 'null';
            s.NullStringWrite = 'null';
            s.JDBCDataSourceFile = '';
            s.UseRegistryForSources = 'yes';
            s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
            s.DefaultRowPreFetch = '10000';
            setdbprefs(s)
            conn = database('MS Access Database','','password');
            codigo = num2str(similar{2});
            tipo = num2str(similar{3}); 
            e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacros WHERE codigo_estudiante = ' '''' codigo ''''  'AND codigo_prueba = ' '''' tipo '''']);
            e = fetch(e);
            close(e)
            pepe_simulacros = e.Data;
            close(conn)    

            s.DataReturnFormat = 'cellarray';
            s.ErrorHandling = 'store';
            s.NullNumberRead = 'NaN';
            s.NullNumberWrite = 'NaN';
            s.NullStringRead = 'null';
            s.NullStringWrite = 'null'; 
            s.JDBCDataSourceFile = '';
            s.UseRegistryForSources = 'yes';
            s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
            s.DefaultRowPreFetch = '10000';
            setdbprefs(s)
            conn = database('MS Access Database','','password');
            codigo = num2str(similar{2});
            e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_niveles_pensamiento WHERE codigo_estudiante = ' '''' codigo '''']);
            e = fetch(e);
            close(e)
            pepe_preguntas = e.Data;
            close(conn) 
            sinresultados = 'No Data';  
            
            if tipo == '1'
                
                %%%%ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO
                %%%%REGISTRARDOS AUN.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)           
                     %%%%%%%%%%%% INSERTAR EN LA TABLA SIMULACROS PRIMERA VEZ%%%%%%             
                    %juanito='ningun registro';
                    % Set preferences with setdbprefs.
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000'; 
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    insert(conn,'Simulacros',{'fecha','codigo_estudiante','codigo_prueba'},similar);
                    close(conn)
                    clear recorte pregunta numero_respuesta columnas_preguntas
                    %total_respuesta{fotos} = acumulado_respuestas;    
                    %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                    bd = [str2double(codigo),acumulado_respuestas];  
                    %cellbd = num2cell(bd);
                                        
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    % Make connection to database.  Note that the password has been omitted.
                    % Using ODBC driver.
                    conn = database('MS Access Database','','password');
                    insert(conn,'Preguntas_niveles_pensamiento',{'codigo_estudiante','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74'},bd)
                    insert(conn,'Copia_Preguntas_niveles_pensamiento',{'codigo_estudiante','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74'},bd)          
                    % Close database connection.
                    close(conn)

                    similar=[];
                    codigo=''; 
                    AUX1=[];
                    acumulado_respuestas=[]; 
                    %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                    %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                    %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                    %%OBVIAMENTE SE BORRAN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)    
                    
                     %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    fecha = similar{1};  
                    % Read data from database.
                    e = exec(conn,['UPDATE Simulacros SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo ''''  'AND codigo_prueba = ' '''' tipo '''']);
                    e = fetch(e);
                    close(e)

                    bd = [str2double(codigo),acumulado_respuestas];  
                    %cellbd = num2cell(bd);
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    % Make connection to database.  Note that the password has been omitted.
                    % Using ODBC driver.
                    conn = database('MS Access Database','','password');
                    insert(conn,'Preguntas_niveles_pensamiento',{'codigo_estudiante','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74'},bd)
                    insert(conn,'Copia_Preguntas_niveles_pensamiento',{'codigo_estudiante','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74'},bd)
                    % Close database connection.
                    close(conn)

                    similar=[];
                    codigo='';
                    AUX1=[];
                    acumulado_respuestas=[]; 

                else
                    %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                    %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                    %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                    %%ALGO ENTOCES SOLO SE ACTUALIZAN 
                    
                    %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    fecha = similar{1};  
                    % Read data from database.
                    e = exec(conn,['UPDATE Simulacros SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo ''''  'AND codigo_prueba = ' '''' tipo '''']);
                    e = fetch(e);
                    close(e)

                    %%%%%PRIMERO PREGUNTAR SI LA TABLA "PREGUNTAS" TIENE DATOS
                    %%%%%ESTO QUIERE DECIR QUE SE ANALIZO PERO NO SE CALIFICO
                    %%%%%SINO QUE SE VOLVIO A ANALIZAR PORQUE TAL VEZ QUIERIA
                    %%%%%RECTIFICAR ALGUNOS VALORES ALGO FALLO EN LA ANALIZADA
                    %%%%%Y SE QUERIA COMPROBAR SI ES ASI SE PROCEDE A ACTULIZAR
                    %%%%%DICHOS DATOS.                

                    %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                     bd = [str2num(codigo),acumulado_respuestas];  

                     s.DataReturnFormat = 'cellarray';
                     s.ErrorHandling = 'store';
                     s.NullNumberRead = 'NaN';
                     s.NullNumberWrite = 'NaN';
                     s.NullStringRead = 'null';
                     s.NullStringWrite = 'null';
                     s.JDBCDataSourceFile = '';
                     s.UseRegistryForSources = 'yes';
                     s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                     s.DefaultRowPreFetch = '10000';
                     setdbprefs(s)
                     conn = database('MS Access Database','','password');
                     % Read data from database.
                     e = exec(conn,['UPDATE Preguntas_niveles_pensamiento SET preg1 = ' '''' num2str(bd(2)) '''' ', preg2 = ' '''' num2str(bd(3)) '''' ', preg3 = ' '''' num2str(bd(4)) '''' ', preg4 = ' '''' num2str(bd(5)) '''' ', preg5 = ' '''' num2str(bd(6)) '''' ', preg6 = ' '''' num2str(bd(7)) '''' ', preg7 = ' '''' num2str(bd(8)) '''' ', preg8 = ' '''' num2str(bd(9)) '''' ', preg9 = ' '''' num2str(bd(10)) '''' ', preg10 = ' '''' num2str(bd(11)) '''' ', preg11 = ' '''' num2str(bd(12)) '''' ', preg12 = ' '''' num2str(bd(13)) '''' ', preg13 = ' '''' num2str(bd(14)) '''' ', preg14 = ' '''' num2str(bd(15)) '''' ', preg15 = ' '''' num2str(bd(16)) '''' ', preg16 = ' '''' num2str(bd(17)) '''' ', preg17 = ' '''' num2str(bd(18)) '''' ', preg18 = ' '''' num2str(bd(19)) '''' ', preg19 = ' '''' num2str(bd(20)) '''' ', preg20 = ' '''' num2str(bd(21)) '''' ', preg21 = ' '''' num2str(bd(22)) '''' ', preg22 = ' '''' num2str(bd(23)) '''' ', preg23 = ' '''' num2str(bd(24)) '''' ', preg24 = ' '''' num2str(bd(25)) '''' ', preg25 = ' '''' num2str(bd(26)) '''' ', preg26 = ' '''' num2str(bd(27)) '''' ', preg27 = ' '''' num2str(bd(28)) '''' ', preg28 = ' '''' num2str(bd(29)) '''' ', preg29 = ' '''' num2str(bd(30)) '''' ', preg30 = ' '''' num2str(bd(31)) '''' ', preg31 = ' '''' num2str(bd(32)) '''' ', preg32 = ' '''' num2str(bd(33)) '''' ', preg33 = ' '''' num2str(bd(34)) '''' ', preg34 = ' '''' num2str(bd(35)) '''' ', preg35 = ' '''' num2str(bd(36)) '''' ', preg36 = ' '''' num2str(bd(37)) '''' ', preg37 = ' '''' num2str(bd(38)) '''' ', preg38 = ' '''' num2str(bd(39)) '''' ', preg39 = ' '''' num2str(bd(40)) '''' ', preg40 = ' '''' num2str(bd(41)) '''' ', preg41 = ' '''' num2str(bd(42)) '''' ', preg42 = ' '''' num2str(bd(43)) '''' ', preg43 = ' '''' num2str(bd(44)) '''' ', preg44 = ' '''' num2str(bd(45)) '''' ', preg45 = ' '''' num2str(bd(46)) '''' ', preg46 = ' '''' num2str(bd(47)) '''' ', preg47 = ' '''' num2str(bd(48)) '''' ', preg48 = ' '''' num2str(bd(49)) '''' ', preg49 = ' '''' num2str(bd(50)) '''' ', preg50 = ' '''' num2str(bd(51)) '''' ', preg51 = ' '''' num2str(bd(52)) '''' ', preg52 = ' '''' num2str(bd(53)) '''' ', preg53 = ' '''' num2str(bd(54)) '''' ', preg54 = ' '''' num2str(bd(55)) '''' ', preg55 = ' '''' num2str(bd(56)) '''' ', preg56 = ' '''' num2str(bd(57)) '''' ', preg57 = ' '''' num2str(bd(58)) '''' ', preg58 = ' '''' num2str(bd(59)) '''' ', preg59 = ' '''' num2str(bd(60)) '''' ', preg60 = ' '''' num2str(bd(61)) '''' ', preg61 = ' '''' num2str(bd(62)) '''' ', preg62 = ' '''' num2str(bd(63)) '''' ', preg63 = ' '''' num2str(bd(64)) '''' ', preg64 = ' '''' num2str(bd(65)) '''' ', preg65 = ' '''' num2str(bd(66)) '''' ', preg66 = ' '''' num2str(bd(67)) '''' ', preg67 = ' '''' num2str(bd(68)) '''' ', preg68 = ' '''' num2str(bd(69)) '''' ', preg69 = ' '''' num2str(bd(70)) '''' ', preg70 = ' '''' num2str(bd(71)) '''' ', preg71 = ' '''' num2str(bd(72)) '''' ', preg72 = ' '''' num2str(bd(73)) '''' ', preg73 = ' '''' num2str(bd(74)) '''' ', preg74 = ' '''' num2str(bd(75)) '''' ' WHERE codigo_estudiante = ' '''' codigo '''']);
                     e = fetch(e); 
                     close(e)    
  

                     s.DataReturnFormat = 'cellarray';
                     s.ErrorHandling = 'store';
                     s.NullNumberRead = 'NaN';
                     s.NullNumberWrite = 'NaN';
                     s.NullStringRead = 'null';
                     s.NullStringWrite = 'null';
                     s.JDBCDataSourceFile = '';
                     s.UseRegistryForSources = 'yes';
                     s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                     s.DefaultRowPreFetch = '10000';
                     setdbprefs(s)
                     conn = database('MS Access Database','','password');
                     % Read data from database.
                     e = exec(conn,['UPDATE Copia_Preguntas_niveles_pensamiento SET preg1 = ' '''' num2str(bd(2)) '''' ', preg2 = ' '''' num2str(bd(3)) '''' ', preg3 = ' '''' num2str(bd(4)) '''' ', preg4 = ' '''' num2str(bd(5)) '''' ', preg5 = ' '''' num2str(bd(6)) '''' ', preg6 = ' '''' num2str(bd(7)) '''' ', preg7 = ' '''' num2str(bd(8)) '''' ', preg8 = ' '''' num2str(bd(9)) '''' ', preg9 = ' '''' num2str(bd(10)) '''' ', preg10 = ' '''' num2str(bd(11)) '''' ', preg11 = ' '''' num2str(bd(12)) '''' ', preg12 = ' '''' num2str(bd(13)) '''' ', preg13 = ' '''' num2str(bd(14)) '''' ', preg14 = ' '''' num2str(bd(15)) '''' ', preg15 = ' '''' num2str(bd(16)) '''' ', preg16 = ' '''' num2str(bd(17)) '''' ', preg17 = ' '''' num2str(bd(18)) '''' ', preg18 = ' '''' num2str(bd(19)) '''' ', preg19 = ' '''' num2str(bd(20)) '''' ', preg20 = ' '''' num2str(bd(21)) '''' ', preg21 = ' '''' num2str(bd(22)) '''' ', preg22 = ' '''' num2str(bd(23)) '''' ', preg23 = ' '''' num2str(bd(24)) '''' ', preg24 = ' '''' num2str(bd(25)) '''' ', preg25 = ' '''' num2str(bd(26)) '''' ', preg26 = ' '''' num2str(bd(27)) '''' ', preg27 = ' '''' num2str(bd(28)) '''' ', preg28 = ' '''' num2str(bd(29)) '''' ', preg29 = ' '''' num2str(bd(30)) '''' ', preg30 = ' '''' num2str(bd(31)) '''' ', preg31 = ' '''' num2str(bd(32)) '''' ', preg32 = ' '''' num2str(bd(33)) '''' ', preg33 = ' '''' num2str(bd(34)) '''' ', preg34 = ' '''' num2str(bd(35)) '''' ', preg35 = ' '''' num2str(bd(36)) '''' ', preg36 = ' '''' num2str(bd(37)) '''' ', preg37 = ' '''' num2str(bd(38)) '''' ', preg38 = ' '''' num2str(bd(39)) '''' ', preg39 = ' '''' num2str(bd(40)) '''' ', preg40 = ' '''' num2str(bd(41)) '''' ', preg41 = ' '''' num2str(bd(42)) '''' ', preg42 = ' '''' num2str(bd(43)) '''' ', preg43 = ' '''' num2str(bd(44)) '''' ', preg44 = ' '''' num2str(bd(45)) '''' ', preg45 = ' '''' num2str(bd(46)) '''' ', preg46 = ' '''' num2str(bd(47)) '''' ', preg47 = ' '''' num2str(bd(48)) '''' ', preg48 = ' '''' num2str(bd(49)) '''' ', preg49 = ' '''' num2str(bd(50)) '''' ', preg50 = ' '''' num2str(bd(51)) '''' ', preg51 = ' '''' num2str(bd(52)) '''' ', preg52 = ' '''' num2str(bd(53)) '''' ', preg53 = ' '''' num2str(bd(54)) '''' ', preg54 = ' '''' num2str(bd(55)) '''' ', preg55 = ' '''' num2str(bd(56)) '''' ', preg56 = ' '''' num2str(bd(57)) '''' ', preg57 = ' '''' num2str(bd(58)) '''' ', preg58 = ' '''' num2str(bd(59)) '''' ', preg59 = ' '''' num2str(bd(60)) '''' ', preg60 = ' '''' num2str(bd(61)) '''' ', preg61 = ' '''' num2str(bd(62)) '''' ', preg62 = ' '''' num2str(bd(63)) '''' ', preg63 = ' '''' num2str(bd(64)) '''' ', preg64 = ' '''' num2str(bd(65)) '''' ', preg65 = ' '''' num2str(bd(66)) '''' ', preg66 = ' '''' num2str(bd(67)) '''' ', preg67 = ' '''' num2str(bd(68)) '''' ', preg68 = ' '''' num2str(bd(69)) '''' ', preg69 = ' '''' num2str(bd(70)) '''' ', preg70 = ' '''' num2str(bd(71)) '''' ', preg71 = ' '''' num2str(bd(72)) '''' ', preg72 = ' '''' num2str(bd(73)) '''' ', preg73 = ' '''' num2str(bd(74)) '''' ', preg74 = ' '''' num2str(bd(75)) '''' ' WHERE codigo_estudiante = ' '''' codigo '''']);
                     e = fetch(e); 
                     close(e)   

                     similar=[];
                     codigo='';
                     AUX1=[];
                     acumulado_respuestas=[]; 
                end 
            elseif tipo == '2'
               msgbox('Aun no esta en desarrollo','MENSAJE ALERTA');         
            elseif tipo == '3'
               msgbox('Aun no esta en desarrollo','MENSAJE ALERTA'); 
            else
               msgbox('Aun no esta en desarrollo','MENSAJE ALERTA'); 
            end 
        end 
            codigo_aux= num2str(CODIGOS(1));
            a=codigo_aux(2);
            b=codigo_aux(3);
            c=codigo_aux(4);
            d=codigo_aux(5);
            e=codigo_aux(6);               
            codigo_colegio=[a b c];
            grupo =[d e]; 

            s.DataReturnFormat = 'cellarray';
            s.ErrorHandling = 'store';
            s.NullNumberRead = 'NaN';
            s.NullNumberWrite = 'NaN';
            s.NullStringRead = 'null';
            s.NullStringWrite = 'null';
            s.JDBCDataSourceFile = '';
            s.UseRegistryForSources = 'yes';
            s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
            s.DefaultRowPreFetch = '10000';
            setdbprefs(s)
            conn = database('MS Access Database','','password');
            % Read data from database.
            e = exec(conn,['UPDATE Reportar_Ingresos SET Fecha_Analizar = ' '''' fecha '''' ' WHERE Codigo_Colegio = ' '''' codigo_colegio ''''  'AND Grupo = ' '''' grupo '''' 'AND Codigo_Simulacro = ' '''' tipo '''']);
            e = fetch(e);
            close(e)            
            clear agrupar columnas_preguntas numero_respuesta pregunta recorte b Ne AUX1 a acumulado_respuestas aux be dilatar fotos i imagenes  primeras primeras_22 C CODIGOS Elcodigo agrupas ano bd c codigo codigo_aux codigo_colegio conn d dia e fecha grupo mes pathname pepe_preguntas pepe_simulacros s similar sinresultados tipo x 
            set(handles.mensaje,'Visible','on');
            guidata(hObject,handles); 
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    elseif  handles.TipoPrueba == 4  
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SABER 10 y 11   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        %%%%%%%%%%%%%%5%%%%% INICIALIZAR VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%
        handles.imagenes = imagenes;
        %primeras_22 = [];
        acumulado_respuestas=[];  
        codigo='';  
        %agrupar=[]; 
        CODIGOS = [];   
        %AUX1=[];  
        %be= strel('line', 8, -90);   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
        for fotos=1:length(handles.imagenes)
        %%%%%%%%%%%%%%%%preguntar el tipo de sesion%%%%%%%%%%%%%%%%%%%%%
            [Numero_marcas] = marcas_identificar_sesion(handles.imagenes{fotos});
            if Numero_marcas==15
                      
               %%%%%%%%%%%%%%%%% Preguntas de segunda sesion%%%%%%%%%%%%% 
               sesion= 2;
               [dilatar] = marcas_saber1011(handles.imagenes{fotos});              
                
               for recorte=1:length(dilatar);      

                  
                    if recorte==1
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    elseif recorte==7
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else 
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end
                   
                    
                    for b=1:Ne  
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                  
                         
                         if recorte==1  
                             opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;   
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo='';
                                 break  
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         
                         if recorte==3 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end  
                         if recorte==4
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break 
                             end
                         end 
                         if recorte==5 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end
                         
                         if recorte==7         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end 
                         
                    end
               end
 
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%
               
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
               
                    for i=1:4 
                        if i==1
                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                               
                            answer =inputdlg(strcat('CODIGO FOTO: ',num2str(fotos)),'Ingresa el codigo.'); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else 
                            similar{i}=CODIGOS(fotos);  
                           end
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';   

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)
                        
                        bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                        
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [similar{1},bd];           % ingresar el codigo 

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)  
                         
                         e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)    
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[]; 
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];                            
                   end         
            else   
            %%%%%%%%%%%%%%%%%%%%% Preguntas de Primera sesion%%%%%%%%%%%%%%
               sesion= 1; 
               [dilatar] = marcas_saber1011_sesion1(handles.imagenes{fotos});   
               %componente_flexible=0;          
                 
               for recorte=1:length(dilatar);    
                    if recorte==1  
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6   
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    elseif recorte==7
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else 
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end 
                       
                      
                    for b=1:Ne   
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                                       
                         if recorte==1  
                            opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;
                             
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo=''; 
                                 break 
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         if recorte==3
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end 
                         if recorte==4 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==5         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end 
                         
                         if recorte==7         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end 
                         
                    end
               end
                         
            %%%%%termina la prueba sesion 1
            %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS_SABER_SESION1%%%%       
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%         
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
              clear AUX1 Ancho_Pregunta Largo_pregunta Ne Numero_marcas dilatar numero_respuesta opciones pregunta recorte   
                    for i=1:4   
                        if i==1

                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                            answer =inputdlg( strcat('CODIGO FOTO: ', num2str(fotos)), 'Ingresa el codigo. de la foto: '); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else  
                            similar{i}=CODIGOS(fotos);  
                           end
                           
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';    

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                         % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [similar{1},bd];           % ingresar el codigo 

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)   
                         
                         e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)  
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];                            
                   end
                   
            end     
        end   
            codigo_aux= num2str(CODIGOS(1));
            a=codigo_aux(2);
            b=codigo_aux(3);
            c=codigo_aux(4);
            d=codigo_aux(5); 
            e=codigo_aux(6);               
            codigo_colegio=[a b c];
            grupo =[d e]; 

            s.DataReturnFormat = 'cellarray';
            s.ErrorHandling = 'store';
            s.NullNumberRead = 'NaN';
            s.NullNumberWrite = 'NaN';
            s.NullStringRead = 'null';
            s.NullStringWrite = 'null';
            s.JDBCDataSourceFile = '';
            s.UseRegistryForSources = 'yes';
            s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
            s.DefaultRowPreFetch = '10000';
            setdbprefs(s)
            conn = database('MS Access Database','','password');
            % Read data from database.
            e = exec(conn,['UPDATE Reportar_Ingresos SET Fecha_Analizar = ' '''' fecha '''' ' WHERE Codigo_Colegio = ' '''' codigo_colegio ''''  'AND Grupo = ' '''' grupo '''' 'AND Codigo_Simulacro = ' '''' tipo '''']);
            e = fetch(e);
            close(e)            
            clear agrupar columnas_preguntas numero_respuesta pregunta recorte b Ne AUX1 a acumulado_respuestas aux be dilatar fotos i imagenes  primeras primeras_22 C CODIGOS Elcodigo agrupas ano bd c codigo codigo_aux codigo_colegio conn d dia e fecha grupo mes pathname pepe_preguntas pepe_simulacros s similar sinresultados tipo x 
            set(handles.mensaje,'Visible','on');
            guidata(hObject,handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
    elseif  handles.TipoPrueba == 5  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SABER 10 Y 11 NUEVO %%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%%%%%%5%%%%% INICIALIZAR VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.imagenes = imagenes;
        %primeras_22 = [];
        acumulado_respuestas=[];  
        codigo='';  
        %agrupar=[]; 
        CODIGOS = [];   
        %AUX1=[];  
        %be= strel('line', 8, -90);   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
        for fotos=1:length(handles.imagenes)
        %%%%%%%%%%%%%%%% preguntar el tipo de sesion  %%%%%%%%%%%%%%%%%%%%%
            [Numero_marcas] = marcas_identificar_sesion(handles.imagenes{fotos});
            if Numero_marcas==15
                      
               %%%%%%%%%%%%%%%%% Preguntas de segunda sesion%%%%%%%%%%%%% 
               sesion= 2;
               [dilatar] = marcas_saber1011_nuevo(handles.imagenes{fotos});              
                
               for recorte=1:length(dilatar);      

                  
                    if recorte==1
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    elseif recorte==7
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else 
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end
                   
                    
                    for b=1:Ne  
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                  
                         
                         if recorte==1  
                             opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;   
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo='';
                                 break  
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         
                         if recorte==3 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end  
                         if recorte==4
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break 
                             end
                         end 
                         if recorte==5 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end
                         
                         if recorte==7         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end 
                         
                    end
               end
 
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%
               
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
               
                    for i=1:4 
                        if i==1
                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                               
                            answer =inputdlg(strcat('CODIGO FOTO: ',num2str(fotos)),'Ingresa el codigo.'); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else 
                            similar{i}=CODIGOS(fotos);  
                           end
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado el SIMULACRO 
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
                    
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';   

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso 2
                        
                        bd = [str2num(similar{3}),bd];      % INGRESAR EL SIMULACRO
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                        
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)
                        
                        bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [str2num(similar{3}),bd];      % INGRESAR EL SIMULACRO
                        
                        bd = [similar{1},bd];           % ingresar el codigo 
                        
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [str2num(similar{3}),bd];
                         
                         bd = [similar{1},bd];           % ingresar el codigo 

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)  
                         
                        % e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                        e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                        e = fetch(e); 
                         close(e)    
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[]; 
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];                            
                   end         
            else   
            %%%%%%%%%%%%%%%%%%%%% Preguntas de Primera sesion%%%%%%%%%%%%%%
               sesion= 1; 
               [dilatar] = marcas_saber1011_sesion1(handles.imagenes{fotos});   
               %componente_flexible=0;          
                 
               for recorte=1:length(dilatar);    
                    if recorte==1  
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6   
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    elseif recorte==7
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else 
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end 
                       
                      
                    for b=1:Ne   
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                                       
                         if recorte==1  
                            opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;
                             
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo=''; 
                                 break 
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         if recorte==3
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end 
                         if recorte==4 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==5         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end 
                         
                         if recorte==7         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end 
                         
                    end
               end
                         
            %%%%%termina la prueba sesion 1
            %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS_SABER_SESION1%%%%       
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%         
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
              clear AUX1 Ancho_Pregunta Largo_pregunta Ne Numero_marcas dilatar numero_respuesta opciones pregunta recorte   
                    for i=1:4   
                        if i==1

                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                            answer =inputdlg( strcat('CODIGO FOTO: ', num2str(fotos)), 'Ingresa el codigo. de la foto: '); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else  
                            similar{i}=CODIGOS(fotos);  
                           end
                           
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';    

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        
                        bd = [str2num(similar{3}),bd];
                         
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        
                        bd = [str2num(similar{3}),bd];
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                         % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [str2num(similar{3}),bd];
                         
                         bd = [similar{1},bd];           % ingresar el codigo 

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         %e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)   
                         
                         %e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)  
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];                            
                   end
                   
            end     
        end   
            codigo_aux= num2str(CODIGOS(1));
            a=codigo_aux(2);
            b=codigo_aux(3);
            c=codigo_aux(4);
            d=codigo_aux(5); 
            e=codigo_aux(6);               
            codigo_colegio=[a b c];
            grupo =[d e]; 

            s.DataReturnFormat = 'cellarray';
            s.ErrorHandling = 'store';
            s.NullNumberRead = 'NaN';
            s.NullNumberWrite = 'NaN';
            s.NullStringRead = 'null';
            s.NullStringWrite = 'null';
            s.JDBCDataSourceFile = '';
            s.UseRegistryForSources = 'yes';
            s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
            s.DefaultRowPreFetch = '10000';
            setdbprefs(s)
            conn = database('MS Access Database','','password');
            % Read data from database.
            e = exec(conn,['UPDATE Reportar_Ingresos SET Fecha_Analizar = ' '''' fecha '''' ' WHERE Codigo_Colegio = ' '''' codigo_colegio ''''  'AND Grupo = ' '''' grupo '''' 'AND Codigo_Simulacro = ' '''' tipo '''']);
            e = fetch(e);
            close(e)            
            clear agrupar columnas_preguntas numero_respuesta pregunta recorte b Ne AUX1 a acumulado_respuestas aux be dilatar fotos i imagenes  primeras primeras_22 C CODIGOS Elcodigo agrupas ano bd c codigo codigo_aux codigo_colegio conn d dia e fecha grupo mes pathname pepe_preguntas pepe_simulacros s similar sinresultados tipo x 
            set(handles.mensaje,'Visible','on');
            guidata(hObject,handles);
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif  (handles.TipoPrueba == 6) || (handles.TipoPrueba == 7) || (handles.TipoPrueba == 8)  
    %%%%%%%%%%%% NUMERO SIMULACRO SABER PRUEBA 9 %%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%5%%%%% INICIALIZAR VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.imagenes = imagenes;
        acumulado_respuestas=[];  
        codigo='';  
        CODIGOS = [];   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        
        for fotos=1:length(handles.imagenes)
        %%%%%%%%%%%%%%%% preguntar el tipo de sesion  %%%%%%%%%%%%%%%%%%%%%
            [Numero_marcas] = marcas_identificar_sesion(handles.imagenes{fotos});

            %%%%%%%%%%%%%%%%%%%%% Preguntas de Primera sesion%%%%%%%%%%%%%%
               sesion= 1; 
               [dilatar] = marcas_saber1011_sesion1(handles.imagenes{fotos});   
               %componente_flexible=0;          
                 
               for recorte=1:length(dilatar);    
                    if recorte==1  
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6   
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    elseif recorte==7
                        Ne=1; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else 
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end 
                       
                      
                    for b=1:Ne   
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                                       
                         if recorte==1  
                            opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;
                             
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo=''; 
                                 break 
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         if recorte==3
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end 
                         if recorte==4 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==5         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end 
                         
                         if recorte==7         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==1
                                 break
                             end
                         end 
                         
                    end
               end
                         
            %%%%%termina la prueba sesion 1
            %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS_SABER_SESION1%%%%       
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%         
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
              clear AUX1 Ancho_Pregunta Largo_pregunta Ne Numero_marcas dilatar numero_respuesta opciones pregunta recorte   
                    for i=1:4   
                        if i==1

                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                            answer =inputdlg( strcat('CODIGO FOTO: ', num2str(fotos)), 'Ingresa el codigo. de la foto: '); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else  
                            similar{i}=CODIGOS(fotos);  
                           end
                           
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';    

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        
                        bd = [str2num(similar{3}),bd];
                         
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        
                        bd = [str2num(similar{3}),bd];
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                         % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [str2num(similar{3}),bd];
                         
                         bd = [similar{1},bd];           % ingresar el codigo 

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         %e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)   
                         
                         %e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)  
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];                            
                    end     
        end
        
            codigo_aux= num2str(CODIGOS(1));
            a=codigo_aux(2);
            b=codigo_aux(3);
            c=codigo_aux(4);
            d=codigo_aux(5); 
            e=codigo_aux(6);               
            codigo_colegio=[a b c];
            grupo =[d e]; 

            s.DataReturnFormat = 'cellarray';
            s.ErrorHandling = 'store';
            s.NullNumberRead = 'NaN';
            s.NullNumberWrite = 'NaN';
            s.NullStringRead = 'null';
            s.NullStringWrite = 'null';
            s.JDBCDataSourceFile = '';
            s.UseRegistryForSources = 'yes';
            s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
            s.DefaultRowPreFetch = '10000';
            setdbprefs(s)
            conn = database('MS Access Database','','password');
            % Read data from database.
            e = exec(conn,['UPDATE Reportar_Ingresos SET Fecha_Analizar = ' '''' fecha '''' ' WHERE Codigo_Colegio = ' '''' codigo_colegio ''''  'AND Grupo = ' '''' grupo '''' 'AND Codigo_Simulacro = ' '''' tipo '''']);
            e = fetch(e);
            close(e)            
            clear agrupar columnas_preguntas numero_respuesta pregunta recorte b Ne AUX1 a acumulado_respuestas aux be dilatar fotos i imagenes  primeras primeras_22 C CODIGOS Elcodigo agrupas ano bd c codigo codigo_aux codigo_colegio conn d dia e fecha grupo mes pathname pepe_preguntas pepe_simulacros s similar sinresultados tipo x 
            set(handles.mensaje,'Visible','on');
            guidata(hObject,handles);
             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    elseif  handles.TipoPrueba == 9  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% SABER 10 Y 11 CON 4 RESPUESTA ABIERTAS %%%%%%%%%%%%%%%%%%%%%%%%%   
%%%%%%%%%%%%%%5%%%%% INICIALIZAR VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.imagenes = imagenes;
        %primeras_22 = [];
        acumulado_respuestas=[];  
        codigo='';  
        %agrupar=[]; 
        CODIGOS = [];   
        %AUX1=[];  
        %be= strel('line', 8, -90);   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
        for fotos=1:length(handles.imagenes)
        %%%%%%%%%%%%%%%% preguntar el tipo de sesion  %%%%%%%%%%%%%%%%%%%%%
            [Numero_marcas] = marcas_identificar_sesion(handles.imagenes{fotos});
            if Numero_marcas==13
                      
               %%%%%%%%%%%%%%%%% Preguntas de segunda sesion%%%%%%%%%%%%% 
               sesion= 2;
               [dilatar] = marcas_saber1011_cuatro_abiertas_sesion2(handles.imagenes{fotos});              
                
               for recorte=1:length(dilatar);      

                  
                    if recorte==1
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6
                        Ne=4; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
%                     elseif recorte==7
%                         Ne=1; 
%                         Largo_pregunta=size(dilatar{recorte},2);
%                         Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else 
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end
                   
                    
                    for b=1:Ne  
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                  
                         
                         if recorte==1  
                             opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;   
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo='';
                                 break  
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         
                         if recorte==3 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end  
                         if recorte==4
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break 
                             end
                         end 
                         if recorte==5 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==4
                                 break
                             end
                         end
                         
%                          if recorte==7         
%                              opciones=4;  
%                              [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);   
%                              AUX1 = acumulado_respuestas;
%                              acumulado_respuestas = [AUX1 numero_respuesta];
%                              if b==1
%                                  break
%                              end
%                          end 
                         
                    end
               end
 
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%
               
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
               
                    for i=1:4 
                        if i==1
                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                               
                            answer =inputdlg(strcat('CODIGO FOTO: ',num2str(fotos)),'Ingresa el codigo.'); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else 
                            similar{i}=CODIGOS(fotos);  
                           end
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado el SIMULACRO 
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
                     
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';   

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso 2
                        
                        bd = [str2num(similar{3}),bd];      % INGRESAR EL SIMULACRO
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                        
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)
                        
                        bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [str2num(similar{3}),bd];      % INGRESAR EL SIMULACRO
                        
                        bd = [similar{1},bd];           % ingresar el codigo 
                        
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [str2num(similar{3}),bd];
                         
                         bd = [similar{1},bd];           % ingresar el codigo 

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)  
                         
                        % e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                        e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                        e = fetch(e); 
                         close(e)    
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[]; 
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];                            
                   end         
            else   
            %%%%%%%%%%%%%%%%%%%%% Preguntas de Primera sesion%%%%%%%%%%%%%%
               sesion= 1; 
               [dilatar] = marcas_saber1011_cuatro_abiertas_sesion1(handles.imagenes{fotos});   
               %componente_flexible=0;          
                 
               for recorte=1:length(dilatar);    
                    if recorte==1  
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6   
                        Ne=4; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
%                     elseif recorte==7
%                         Ne=1; 
%                         Largo_pregunta=size(dilatar{recorte},2);
%                         Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else  
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end 
                       
                      
                    for b=1:Ne    
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                                       
                         if recorte==1  
                            opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;
                             
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo=''; 
                                 break 
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         if recorte==3
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end 
                         if recorte==4 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==5         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==4
                                 break
                             end
                         end 
                         
%                          if recorte==7         
%                              opciones=4;  
%                              [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
%                              AUX1 = acumulado_respuestas;
%                              acumulado_respuestas = [AUX1 numero_respuesta];
%                              if b==1
%                                  break
%                              end
%                          end 
                         
                    end
               end  
                         
            %%%%%termina la prueba sesion 1
            %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS_SABER_SESION1%%%%       
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%         
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
              clear AUX1 Ancho_Pregunta Largo_pregunta Ne Numero_marcas dilatar numero_respuesta opciones pregunta recorte   
                    for i=1:4   
                        if i==1

                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                            answer =inputdlg( strcat('CODIGO FOTO: ', num2str(fotos)), 'Ingresa el codigo. de la foto: '); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else  
                            similar{i}=CODIGOS(fotos);  
                           end
                           
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';    

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        
                        bd = [str2num(similar{3}),bd];
                         
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        
                        bd = [str2num(similar{3}),bd];
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                         % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [str2num(similar{3}),bd];
                         
                         bd = [similar{1},bd];           % ingresar el codigo 

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         %e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)   
                         
                         %e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)   
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];                            
                   end
                   
            end     
        end   
            codigo_aux= num2str(CODIGOS(1));
            a=codigo_aux(2);
            b=codigo_aux(3);
            c=codigo_aux(4);
            d=codigo_aux(5); 
            e=codigo_aux(6);               
            codigo_colegio=[a b c];
            grupo =[d e]; 

            s.DataReturnFormat = 'cellarray';
            s.ErrorHandling = 'store';
            s.NullNumberRead = 'NaN';
            s.NullNumberWrite = 'NaN';
            s.NullStringRead = 'null';
            s.NullStringWrite = 'null';
            s.JDBCDataSourceFile = '';
            s.UseRegistryForSources = 'yes';
            s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
            s.DefaultRowPreFetch = '10000';
            setdbprefs(s)
            conn = database('MS Access Database','','password');
            % Read data from database.
            e = exec(conn,['UPDATE Reportar_Ingresos SET Fecha_Analizar = ' '''' fecha '''' ' WHERE Codigo_Colegio = ' '''' codigo_colegio ''''  'AND Grupo = ' '''' grupo '''' 'AND Codigo_Simulacro = ' '''' tipo '''']);
            e = fetch(e);
            close(e)            
            clear agrupar columnas_preguntas numero_respuesta pregunta recorte b Ne AUX1 a acumulado_respuestas aux be dilatar fotos i imagenes  primeras primeras_22 C CODIGOS Elcodigo agrupas ano bd c codigo codigo_aux codigo_colegio conn d dia e fecha grupo mes pathname pepe_preguntas pepe_simulacros s similar sinresultados tipo x 
            set(handles.mensaje,'Visible','on');
            guidata(hObject,handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
    elseif handles.TipoPrueba == 10      

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% SABER 9 CON economica y financiera especial %%%%%%%%%%%%%%%%%%%%%%%%%   
%%%%%%%%%%%%%%5%%%%% INICIALIZAR VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.imagenes = imagenes;
        %primeras_22 = [];
        acumulado_respuestas=[];  
        total_acumulado=[];
        codigo='';  
        %agrupar=[]; 
        CODIGOS = [];   
        %AUX1=[];  
        %be= strel('line', 8, -90);   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
        for fotos=1:length(handles.imagenes)
        %%%%%%%%%%%%%%%% preguntar el tipo de sesion  %%%%%%%%%%%%%%%%%%%%%
            [Numero_marcas] = marcas_identificar_sesion(handles.imagenes{fotos});
            if Numero_marcas==13
                      
               %%%%%%%%%%%%%%%%% Preguntas de segunda sesion%%%%%%%%%%%%% 
               sesion= 2;
               [dilatar] = marcas_saber1011_cuatro_abiertas_sesion2(handles.imagenes{fotos});              
                
               for recorte=1:length(dilatar);      

                  
                    if recorte==1
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6
                        Ne=4; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
%                     elseif recorte==7
%                         Ne=1; 
%                         Largo_pregunta=size(dilatar{recorte},2);
%                         Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else 
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end
                   
                    
                    for b=1:Ne  
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                  
                         
                         if recorte==1  
                             opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;   
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo='';
                                 break  
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         
                         if recorte==3 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end  
                         if recorte==4
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break 
                             end
                         end 
                         if recorte==5 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion2_cuatro_abiertas(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==4
                                 break
                             end
                         end
                         
%                          if recorte==7         
%                              opciones=4;  
%                              [numero_respuesta] = clasificacion_Saber1011_nuevo(pregunta,opciones,b,recorte);   
%                              AUX1 = acumulado_respuestas;
%                              acumulado_respuestas = [AUX1 numero_respuesta];
%                              if b==1
%                                  break
%                              end
%                          end 
                         
                    end
               end
 
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%
               
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
               
                    for i=1:4 
                        if i==1
                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                               
                            answer =inputdlg(strcat('CODIGO FOTO: ',num2str(fotos)),'Ingresa el codigo.'); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else 
                            similar{i}=CODIGOS(fotos);  
                           end
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado el SIMULACRO 
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
                     
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';   

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso 2
                        
                        bd = [str2num(similar{3}),bd];      % INGRESAR EL SIMULACRO
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo 
                        
                        for i=1:18 
                            total_acumulado(111 + i) =  acumulado_respuestas(i);                           
                        end        
                        bd = total_acumulado;
 
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)
                        
                        bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [str2num(similar{3}),bd];      % INGRESAR EL SIMULACRO
                        
                        bd = [similar{1},bd];           % ingresar el codigo 
                                          
                         for i=1:18 
                            total_acumulado(111 + i) =  acumulado_respuestas(i);                           
                        end        
                        bd = total_acumulado;
 
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)
                        %insert(conn,'Copia_Preguntas_Saber_Sesion2',{'codigo_estudiante','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142'},bd)
                        % Close database connection.
                        close(conn)
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                        
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [2,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [str2num(similar{3}),bd];
                         
                         bd = [similar{1},bd];           % ingresar el codigo 
                         
                         for i=1:18 
                            total_acumulado(111 + i) =  acumulado_respuestas(i);                            
                         end        
                        bd = total_acumulado;

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)  
                         
                        % e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                        e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                        e = fetch(e); 
                         close(e)    
                         
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        % Make connection to database.  Note that the password has been omitted.
                        % Using ODBC driver.
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                            
                        insert(conn,'Preguntas_Saber_Sesion2',{'codigo_estudiante','Identificacion_Prueba','sesion','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74','preg75','preg76','preg77','preg78','preg79','preg80','preg81','preg82','preg83','preg84','preg85','preg86','preg87','preg88','preg89','preg90','preg91','preg92','preg93','preg94','preg95','preg96','preg97','preg98','preg99','preg100','preg101','preg102','preg103','preg104','preg105','preg106','preg107','preg108','preg109','preg110','preg111','preg112','preg113','preg114','preg115','preg116','preg117','preg118','preg119','preg120','preg121','preg122','preg123','preg124','preg125','preg126','preg127','preg128','preg129','preg130','preg131','preg132','preg133','preg134','preg135','preg136','preg137','preg138','preg139','preg140','preg141','preg142','preg143','preg144'},bd)    
                        close(conn)

                        similar=[]; 
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];           
                   end         
            else   
            %%%%%%%%%%%%%%%%%%%%% Preguntas de Primera sesion%%%%%%%%%%%%%%
               sesion= 1; 
               [dilatar] = marcas_saber1011_cuatro_abiertas_sesion1(handles.imagenes{fotos});   
               %componente_flexible=0;          
                 
               for recorte=1:length(dilatar);    
                    if recorte==1  
                        Ne=8;
                        Largo_pregunta=size(dilatar{recorte},2)/Ne;
                        Ancho_Pregunta=size(dilatar{recorte},1);
                    elseif recorte==6   
                        Ne=4; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
%                     elseif recorte==7
%                         Ne=1; 
%                         Largo_pregunta=size(dilatar{recorte},2);
%                         Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    else  
                        Ne=35; 
                        Largo_pregunta=size(dilatar{recorte},2);
                        Ancho_Pregunta=size(dilatar{recorte},1)/Ne;
                    end 
                       
                      
                    for b=1:Ne   
                         [pregunta] = recortar_columna_pregunta_sin_area(dilatar , b ,recorte, Largo_pregunta, Ancho_Pregunta);                                       
                         if recorte==1  
                            opciones=10;
                            [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);  
                            AUX1 = codigo;
                             
                            codigo = [AUX1 num2str(numero_respuesta-1)];
                            
                            if b==8 
                                 CODIGOS(fotos) = str2double(codigo);
                                 codigo=''; 
                                 break 
                            end
                         end  
                         
                         if recorte==2 
                             opciones=4; 
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end 
                         end  
                         if recorte==3
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end 
                         if recorte==4 
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end   
                         if recorte==5         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==35
                                 break
                             end
                         end
                         if recorte==6         
                             opciones=4;  
                             [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
                             AUX1 = acumulado_respuestas;
                             acumulado_respuestas = [AUX1 numero_respuesta];
                             if b==4
                                 break
                             end
                         end 
                         
%                          if recorte==7         
%                              opciones=4;  
%                              [numero_respuesta] = clasificacion_Saber1011_sesion1(pregunta,opciones,b,recorte);   
%                              AUX1 = acumulado_respuestas;
%                              acumulado_respuestas = [AUX1 numero_respuesta];
%                              if b==1
%                                  break
%                              end
%                          end 
                         
                    end
               end 
                         
            %%%%%termina la prueba sesion 1
            %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS_SABER_SESION1%%%%       
               %%% INGRESAR EN LA BASE DE DATOS LOS RESULTADOS  %%%%%%%%%%%         
               %%%%%PREGUNTAR SI YA ESTA EL CODIGO DEL ESTUDIANTE EN LA TABLA
               %% SIMULACRO SABER SI YA ESTA UPDATE SI NO ESTA, INSERTAR %%  
               %% LO MISMO PARA LA TABLA PREGUNTAS SESION  %%%%%%%%%%%%%%%%   
              clear AUX1 Ancho_Pregunta Largo_pregunta Ne Numero_marcas dilatar numero_respuesta opciones pregunta recorte   
                    for i=1:4   
                        if i==1

                           Elcodigo = isnan(CODIGOS(fotos));
                           if Elcodigo==1
                            answer =inputdlg( strcat('CODIGO FOTO: ', num2str(fotos)), 'Ingresa el codigo. de la foto: '); 
                            similar{i} = str2double(answer{1});
                            CODIGOS = str2double(answer{1});
                           else  
                            similar{i}=CODIGOS(fotos);  
                           end
                           
                        end
                        if i==2
                            similar{i}=handles.TipoPrueba;  
                        end

                        if i==3
                            similar{i}=get(handles.simulacro,'String'); %Almacenar valor ingresado
                        end

                        if i==4
                           dia=get(handles.dia,'String'); %Almacenar valor ingresado
                           mes=get(handles.mes,'String'); %Almacenar valor ingresado
                           ano=get(handles.ano,'String'); %Almacenar valor ingresado

                           fecha=strcat(dia,'/',mes,'/',ano);
                          %fecha = datestr(now, 'dd/mm/yy') ;
                          similar{i}=fecha; 
                        end 
                    end
         %%%%%%%%%%%%%%%%%%%   consultar si ya esta en la base de datos %%% 
         %%%%%%%%%%%%%%%%%%%  Saber si es sesion1 o sesion2  %%%%%%%%%%%%%%
                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo_simulacro = num2str(similar{1});
                    tipo = num2str(similar{2}); 
                    simulacro = num2str(similar{3});
                    %Identificacion_Prueba : es el identificador del simulacro creado o diseñado....            
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacro_saber WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''' 'AND Identificacion_Prueba = ' '''' simulacro '''']);
                    e = fetch(e);
                    close(e)
                    pepe_simulacros = e.Data;
                    close(conn)    

                    s.DataReturnFormat = 'cellarray';
                    s.ErrorHandling = 'store';
                    s.NullNumberRead = 'NaN';
                    s.NullNumberWrite = 'NaN';
                    s.NullStringRead = 'null';
                    s.NullStringWrite = 'null';
                    s.JDBCDataSourceFile = '';
                    s.UseRegistryForSources = 'yes';
                    s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                    s.DefaultRowPreFetch = '10000';
                    setdbprefs(s)
                    conn = database('MS Access Database','','password');
                    codigo = num2str(similar{2});
                    bd_sesion = num2str(sesion);
                    e = exec(conn,['SELECT ALL codigo_estudiante FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro '''' 'AND sesion = ' '''' bd_sesion '''']);
                    e = fetch(e);
                    close(e)
                    pepe_preguntas = e.Data;
                    close(conn)  
                    sinresultados = 'No Data';    

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%   ESTE ES EL CASO DE ESTUDIANTES NUEVOS O QUE NO HAN SIDO 
        %%%%%%%%%   REGISTRARDOS AUN.    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   if (strcmp(pepe_simulacros,sinresultados)==1) && (strcmp(pepe_preguntas,sinresultados)==1)  

                        %%%% INSERTAR SIMILAR EN LA TABLA Simulacro_saber %%%%%%%%%%%%%
                        % Set preferences with setdbprefs.
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        % Write data to database.
                        insert(conn,'Simulacro_saber',{'codigo_estudiante','Codigo_Prueba','Identificacion_Prueba','fecha'},similar)
                        % Close database connection.
                        close(conn)
                        %%%%%%%%%%%%%% INSERTAR EN LA TABLA PREGUNTAS PRIMERA VEZ%%%%%% 
                        
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        
                        bd = [str2num(similar{3}),bd];
                         
                        bd = [similar{1},bd];           % ingresar el codigo 
                         
                        total_acumulado = bd;
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[]; 
                       %%EN EL CASO DE QUE YA ESTEN REGISTRADOS  EN SIMULACROS
                       %%OSEA YA PRESENTARIN LA PRUEBA PERO LA VAN A REPETIR ESO
                       %%QUIERE DECIR QUE NO APARECEN EN PREGUNTAS PORQUE
                       %%%%%  OBVIAMENTE SE BORRAN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
                   elseif (strcmp(pepe_simulacros,sinresultados)==0) && (strcmp(pepe_preguntas,sinresultados)==1)                   
                        
                        %%%%%%%%%%%% ACTUALIZAR EN LA TABLA SIMULACROS %%%% 
                        s.DataReturnFormat = 'cellarray';
                        s.ErrorHandling = 'store';
                        s.NullNumberRead = 'NaN';
                        s.NullNumberWrite = 'NaN';
                        s.NullStringRead = 'null';
                        s.NullStringWrite = 'null';
                        s.JDBCDataSourceFile = '';
                        s.UseRegistryForSources = 'yes';
                        s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                        s.DefaultRowPreFetch = '10000';
                        setdbprefs(s)
                        conn = database('MS Access Database','','password');
                        fecha = similar{4};  
                        % Read data from database.
                        e = exec(conn,['UPDATE Simulacro_saber SET fecha = ' '''' fecha '''' ' WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND codigo_prueba = ' '''' tipo '''']);
                        e = fetch(e);
                        close(e)       
                        bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2          
                        bd = [str2num(similar{3}),bd];
                        %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                        bd = [similar{1},bd];           % ingresar el codigo                        
                        total_acumulado = bd;
                        
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];
                   else
                         %%ES EL CASO EN QUE ESTA EN SIMULACROS, PERO TAMBIEN EN
                         %%PREGUNTAS ESTO PUEDE PASAR PORQUE YA LO PRESENTO, PERO NO
                         %%SE ANALIZO QUERIA VERIFICAR SI LOS DATOS ESTANBAN BIEN O
                         %%ALGO ENTOCES SOLO SE ACTUALIZAN  
                          
                         %%%%%%%%%%%%%% ACTUALIZAR EN LA TABLA PREGUNTAS %%%%%%%%%%%
                         bd = [1,acumulado_respuestas];  % ingresar la sesion en este caso2
                         %nuevo = [componente_flexible,bd];                    % ingresar el componente flexible 
                         bd = [str2num(similar{3}),bd];
                         
                         bd = [similar{1},bd];           % ingresar el codigo 

                         s.DataReturnFormat = 'cellarray';
                         s.ErrorHandling = 'store';
                         s.NullNumberRead = 'NaN';
                         s.NullNumberWrite = 'NaN';
                         s.NullStringRead = 'null';
                         s.NullStringWrite = 'null';
                         s.JDBCDataSourceFile = '';
                         s.UseRegistryForSources = 'yes';
                         s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
                         s.DefaultRowPreFetch = '10000';
                         setdbprefs(s)
                         conn = database('MS Access Database','','password');
                         % Read data from database.
                         bd_sesion = num2str(sesion);

                         %e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = exec(conn,['DELETE FROM Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)   
                         
                         %e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = exec(conn,['DELETE FROM Copia_Preguntas_Saber_Sesion2 WHERE codigo_estudiante = ' '''' codigo_simulacro ''''  'AND Identificacion_Prueba = ' '''' simulacro ''''  'AND sesion = ' '''' bd_sesion '''']);
                         e = fetch(e); 
                         close(e)   

                        total_acumulado = bd;
                        
                        similar=[];
                        codigo='';
                        AUX1=[];
                        acumulado_respuestas=[];                            
                   end        
            end     
        end
            codigo_aux= num2str(CODIGOS(1));
            a=codigo_aux(2);
            b=codigo_aux(3);
            c=codigo_aux(4);
            d=codigo_aux(5); 
            e=codigo_aux(6);               
            codigo_colegio=[a b c];
            grupo =[d e]; 

            s.DataReturnFormat = 'cellarray';
            s.ErrorHandling = 'store';
            s.NullNumberRead = 'NaN';
            s.NullNumberWrite = 'NaN';
            s.NullStringRead = 'null';
            s.NullStringWrite = 'null';
            s.JDBCDataSourceFile = '';
            s.UseRegistryForSources = 'yes';
            s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
            s.DefaultRowPreFetch = '10000';
            setdbprefs(s)
            conn = database('MS Access Database','','password');
            % Read data from database.
            e = exec(conn,['UPDATE Reportar_Ingresos SET Fecha_Analizar = ' '''' fecha '''' ' WHERE Codigo_Colegio = ' '''' codigo_colegio ''''  'AND Grupo = ' '''' grupo '''' 'AND Codigo_Simulacro = ' '''' tipo '''']);
            e = fetch(e);
            close(e)            
            clear agrupar columnas_preguntas numero_respuesta pregunta recorte b Ne AUX1 a acumulado_respuestas aux be dilatar fotos i imagenes  primeras primeras_22 C CODIGOS Elcodigo agrupas ano bd c codigo codigo_aux codigo_colegio conn d dia e fecha grupo mes pathname pepe_preguntas pepe_simulacros s similar sinresultados tipo x 
            set(handles.mensaje,'Visible','on');
            guidata(hObject,handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%             
    elseif  handles.TipoPrueba == 2
        % PERFIL PROFESIONAL..
    else     
        % elseif  handles.TipoPrueba == 3  SABER 3, 5 y 9     
    end
else 
    msgbox('Cargue sus las imagenes por favor','MENSAJE ALERTA');
end

function dia_Callback(hObject, eventdata, handles)
% hObject    handle to dia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dia as text
%        str2double(get(hObject,'String')) returns contents of dia as a double
% --- Executes during object creation, after setting all properties.

function dia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end 

function mes_Callback(hObject, eventdata, handles)
% hObject    handle to mes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mes as text
%        str2double(get(hObject,'String')) returns contents of mes as a double


% --- Executes during object creation, after setting all properties.
function mes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ano_Callback(hObject, ~, handles)
% hObject    handle to ano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of ano as text
% str2double(get(hObject,'String')) returns contents of ano as a double

% --- Executes during object creation, after setting all properties.
function ano_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function simulacro_Callback(hObject, eventdata, handles)
% hObject    handle to simulacro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simulacro as text
%        str2double(get(hObject,'String')) returns contents of simulacro as a double


% --- Executes during object creation, after setting all properties.
function simulacro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simulacro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
