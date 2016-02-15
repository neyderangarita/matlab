  function actualizar_preguntas(pepe)

% % Set preferences with setdbprefs.
% s.DataReturnFormat = 'cellarray';
% s.ErrorHandling = 'store';
% s.NullNumberRead = 'NaN';
% s.NullNumberWrite = 'NaN';
% s.NullStringRead = 'null';
% s.NullStringWrite = 'null';
% s.JDBCDataSourceFile = '';
% s.UseRegistryForSources = 'yes';
% s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
% s.DefaultRowPreFetch = '10000';
% setdbprefs(s)
% % Make connection to database.  Note that the password has been omitted.
% % Using ODBC driver.
% conn = database('MS Access Database','','password');
% codigo = '20010102';
% tipo = '1';
% % Read data from database.
% %e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacros WHERE codigo_estudiante = ' '''' codigo '''']);
% e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacros WHERE codigo_estudiante = ' '''' codigo ''''  'AND codigo_prueba = ' '''' tipo '''']);
% e = fetch(e);
% close(e)
% % Assign data to output variable.
% pepe1 = e.Data;
% % Close database connection.
% close(conn)
% sindatos = 'No Data';
% 
% if (strcmp(pepe1,sindatos)==1)   
%     juanito='ningun registro';
%  
%     
% else
%     
%     juanito='Un registro';
    
    %e = exec(conn,['SELECT ALL codigo_estudiante FROM Simulacros WHERE codigo_estudiante = ' '''' codigo '''']);
    
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
    %repetido = '20010102';
    conn = database('MS Access Database','','password');
    %update(conn, 'Simulacros', {'codigo_estudiante'}, {'neyder'},{'where codigo_estudiante = ' repetido });
    % Set preferences with setdbprefs.   

    update(conn, 'Preguntas', {'codigo_estudiante','preg1','preg2','preg3','preg4','preg5','preg6','preg7','preg8','preg9','preg10','preg11','preg12','preg13','preg14','preg15','preg16','preg17','preg18','preg19','preg20','preg21','preg22','preg23','preg24','preg25','preg26','preg27','preg28','preg29','preg30','preg31','preg32','preg33','preg34','preg35','preg36','preg37','preg38','preg39','preg40','preg41','preg42','preg43','preg44','preg45','preg46','preg47','preg48','preg49','preg50','preg51','preg52','preg53','preg54','preg55','preg56','preg57','preg58','preg59','preg60','preg61','preg62','preg63','preg64','preg65','preg66','preg67','preg68','preg69','preg70','preg71','preg72','preg73','preg74'}, pepe,['where codigo_estudiante =' '''' pepe{1} ''''])   
    
    
% s.DataReturnFormat = 'cellarray';
% s.ErrorHandling = 'store';
% s.NullNumberRead = 'NaN';
% s.NullNumberWrite = 'NaN';
% s.NullStringRead = 'null';
% s.NullStringWrite = 'null';
% s.JDBCDataSourceFile = '';
% s.UseRegistryForSources = 'yes';
% s.TempDirForRegistryOutput = 'C:\Users\neyder\AppData\Local\Temp';
% s.DefaultRowPreFetch = '10000';
% setdbprefs(s)
% 
% conn = database('MS Access Database','','password');
% VIEJO = '20010102';
% NUEVO = 'neyder';
% 
% 
% % Read data from database.
%  % e = exec(conn,['UPDATE Simulacros SET codigo_estudiante = ' '''' NUEVO '''' 'WHERE codigo_estudiante = ' '''' codigo '''']);
%  
%  e = exec(conn,['UPDATE Simulacros SET codigo_estudiante = ' '''' NUEVO '''' 'SET codigo_estudiante = ' '''' NUEVO '''' 'WHERE codigo_estudiante = ' '''' codigo '''']);
%  e = fetch(e);
%  close(e)
%  
% % Assign data to output variable.
% %pepe1 = e.Data;
% % Close database connection.
% close(conn)
% 
% end
    
    
