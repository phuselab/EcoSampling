function temp = GetRegions(BW, rank, win)
    % Use morphological operations
         %se = strel('disk',5);
         %BW = imopen(BW,se);
         se = strel('square',win);
         BW = imclose(BW, se);
       

		[L,obj] = bwlabel(BW,8);                          % Calculating connected components
		%mx=max(max(L))								% There will be mx connected components
%         NUM=10;
%         for i=1:obj
%             fbw = find(L==i);
%             if length(fbw) < NUM 
%                 BW(fbw) = 0;
%             end
%         end
        %RGB = label2rgb(L);
        %imshow(RGB);
		%imagesc(BW);
        
        % Returns the foreground connected component in the binary image
        % supplied that have the specified ranked size(s).
        
        maxL = max(L(:));					%trova numero massimo di componenti
        h = hist(L(find(BW)),[1:maxL]);  %trova gli indici, scandendo per colonne,  degli elementi etichettati
                                            %e calcola le occorrenze per ciascuna label da 1 a maxL
        [sh,sr] = sort(-h);                 %ordina  rispetto al numero di occorrenze
                                            %sh num occorrenze(negative: -8   -6  -4  -2), sr=label corrispondenti
        temp=BW & 0;
        rank=5;
        if rank > maxL
            rank=maxL;
        end
         for i=1:rank    
             temp = temp | (L==sr(i)) ;    %ritorna le prime 5 per dimensione
         end
   