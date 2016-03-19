function[ret,lc,rc, thresh] =  make_pca_tree1(inp_data)
% %UNTITLED Summary of this function goes here
% %   Detailed explanation goes here
% covariance_matrix = data*data';
% [ignore,eigenvector] = eig(covariance_matrix);
% eigenvector = eigenvector(:,1);
% dot_product_data = sum(bsxfun(@times,eigenvector,covariance_matrix));
% THRESH = median(dot_product_data);
%
% leftdata = [];
% rightdata = [];
%
% for i=1:size(data,2)
%     a = data(:,i);
%     dot_product = sum(bsxfun(@times,a,eigenvector));
%     if(dot_product < THRESH)
%         leftdata = [leftdata,a];
%     else
%         righdata = [rightdata,a];
%     end
% end
%
% left_scatter = leftdata*leftdata';
% right_scatter = rightdata*rightdata';
% [ignore lefteigvec] = eig(left_scatter);
% [ignore righteigvec] = eig(right_scatter);
% lefteigvec = lefteigvec(:,1);
% righteigvec = righteigvec(:,1);
%
% if(size(leftdata,2) >= 2)
%
%
%
thresh = [];
ret = [];
st = 1;
lc = [];
rc = [];

q = [];
qid = [];
qidx = 1;
qend = 1;
arr = ones(1,size(inp_data,2));
q(qend,:) = arr;
qid = [qid,st];
qend = qend+1;
st= st+1;

while qidx < qend
    
    currid = qid(qidx);
    tmp = q(qidx,:);
    %data = reshape(tmp,[size(tmp,2),size(tmp,3)]);
    %size(tmp)
    %size(data)
    indices = find(tmp == 1);
    numind = numel(indices);
    data = inp_data(:,indices);
    size(data);
    qidx = qidx + 1;
    covariance_matrix = cov(data');
    [ignore,eigenvector] = eig(covariance_matrix);
    eigenvector = eigenvector(:,1);
    siz_eig=size(eigenvector);
    dot_product_data = sum(bsxfun(@times,data,eigenvector));
    THRESH = median(dot_product_data);
    thresh = [thresh,THRESH];
    
    leftdata = zeros(1,size(inp_data,2));
    rightdata = zeros(1,size(inp_data,2));
    for i=1:size(data,2)
        a = data(:,i);
        dot_product = sum(bsxfun(@times,a,eigenvector));
        if(dot_product < THRESH)
            leftdata(indices(i))=1;
        end
        if(dot_product > THRESH)
            rightdata(indices(i))=1;
        end
        if(dot_product == THRESH)
            class = randi(2,1);
            if(class == 1)
                leftdata(indices(i))=1;
            end
            
            if(class == 2)
                rightdata(indices(i))=1;
            end
        end
    end
    
    
    ret(currid,:) = eigenvector;
    left_ones = numel(find(leftdata==1));
    right_ones = numel(find(rightdata==1));
    if (left_ones >= 3)
        q(qend,:) = leftdata;
        qid = [qid,st];
        lc(currid) = st;
        st = st+ 1;
        qend = qend+ 1;
        %pca_tree= make_pca_tree(idx*2 , leftdata, pca_tree);
    end
    
    if (right_ones >= 3)
        q(qend,:) = rightdata;
        qid = [qid,st];
        rc(currid) = st;
        st =st+ 1;
        qend = qend + 1;
        %pca_tree = make_pca_tree(idx*2 + 1 , rightdata, pca_tree);
    end
    
end

end