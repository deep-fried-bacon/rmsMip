function fieldstring=datastructure(structvar, substructvar, filename)
%Display nested structures in 'structvar'; 'substructvar' is used in
%      recursion, must be [] in main call. Result string is saved in
%      file 'filename'
%filename: filename to use for output
%fieldstring: output (with \n linefeeds)
%example call datastructure(saliencyData,[],'saliencyData.txt')

%store format spacing, set compact:
%disp('started datastructure')
fs=get(0,'FormatSpacing');
format compact

%lines and double lines for display:
lines=repmat('-',1,25);
dlines=repmat('=',1,25);

%get name of variable from call
if exist('substructvar') && ~isempty(substructvar)
%     fieldstring = [substructvar '\n' lines '\n'];
    fieldstring = [substructvar '\n'];
    %disp(class(substructvar))
%     temp = strsplit(substructvar,'\n')
%     temp2 = [temp(2:end)]
%     fieldstring = [temp2 '\n'];

else
   %fieldstring = [inputname(1) '\n' lines '\n'];
    fieldstring = [inputname(1) '\n'];
end

if isstruct(structvar)
    %display main structure at current level of recursion:
    %fieldstring=[fieldstring ' Struct \n' evalc('disp(structvar)')]; 
    %if exist('substructvar') && isempty(substructvar)
    if (exist('substructvar') && ~isempty(substructvar))%exist('substructvar')
        %(substructvar)
    %end
           fieldstring=[fieldstring evalc('disp(structvar)')];
    end
    fieldstring=[fieldstring lines '\n'];
    %get fields names at current level of recursion:
    fields=fieldnames(structvar);
    for k=1:length(fields)
        if isstruct(eval(['structvar.' fields{k}]))
            %recursive call to get substructures:
            fieldstring=[fieldstring datastructure(eval(['structvar.' fields{k}]),fields{k})];
        end
    end
end
%save result
if exist('filename')
     % in main call
     fid=fopen(filename,'w');
     fprintf(fid, fieldstring);
     fclose(fid);
end

%rstore format spacing
set(0,'FormatSpacing',fs);


%disp('ending datastructure')