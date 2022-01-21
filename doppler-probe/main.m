function [] = main(inversion_method,snr,draw_phantom,draw_spectra,draw_result,draw_type,draw_analisis,draw_compare)
%�t�ϊ�(1~5),SN(dB),�t�@���g���`��,�X�y�N�g���`��,���ʕ`��,������(1)/�O����(2),���͕`��,��r�`��

%�p�����[�^���`
run define/parameter.m

%�����`
run define/axis.m

%�`��p�t�@���g��drF�A�v�Z�p�t�@���g��F�𐶐�
run make/phantom.m

%�t�@���g����`��
if draw_phantom
    run draw/phantom.m
end

%W(F->P)���쐬
run make/funcW.m

%P���v�Z�A�m�C�Y��t��
run make/dataP.m

% %P��ۑ�
% save('mat/save_spectra1.mat','P')

% %P��ǂݍ���
% load('mat/save_spectra1.mat','P')

% %P�̈ړ����ς��Ƃ�
% P = movmean(P, 3);

%�ϑ��X�y�N�g����`��
if draw_spectra
    run draw/spectra.m
end

%---------------Invertion theory----------------

%pinv���g����W^(-1)�����߂�B
if inversion_method == 1
    run method/pseudo.m
    run method/goto0.m
end

%Tikhonov 0th
if inversion_method == 2
    run method/Tikhonov0.m
    run method/goto0.m
end

%Tikhonov 1st
if inversion_method == 3
    run method/Tikhonov1.m
    run method/goto0.m
end

%Tikhonov 2nd
if inversion_method == 4
    run method/Tikhonov2.m
    run method/goto0.m
end

%�񕉐���SIRT
if inversion_method == 5
    run method/SIRT.m
end

%minimum Fischer information
if inversion_method == 6
    run method/MFI.m
    run method/goto0.m
end

%���ʂ̕\��
if inversion_method ~= false
    drReF = reshape(ReF, [numVx,numVy]);%�`��p�ɐ��`
    E = drReF - drF;%�G���[=�č\������-�t�@���g��
    
    %�č\�����ʁA�덷��`��
    if draw_result
        run draw/result.m
    end
    
    %�č\�����ʂ��瓾����X�y�N�g�����v�Z�A�t�@���g���Ɣ�r
    if draw_compare
        run draw/compare.m
    end
end

end
