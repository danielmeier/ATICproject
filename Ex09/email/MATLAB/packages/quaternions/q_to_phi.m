function[phi]=q_to_phi(q_IB)

coder.inline('always');

% parameters
mue_IB=q_IB(:,1);
eta_IB1=q_IB(:,2);
eta_IB2=q_IB(:,3);
eta_IB3=q_IB(:,4);

phi=zeros(length(mue_IB),3);

for i=1:length(mue_IB)
    % phi
    phi(i,1)=atan2(2*(mue_IB(i)*eta_IB1(i) + eta_IB2(i)*eta_IB3(i)),1-2*(eta_IB1(i)^2+eta_IB2(i)^2));
    % theta
    phi(i,2)=asin(2*(mue_IB(i)*eta_IB2(i) - eta_IB1(i)*eta_IB3(i)));
    % psi
    phi(i,3)=atan2(2*(mue_IB(i)*eta_IB3(i) + eta_IB1(i)*eta_IB2(i)),1-2*(eta_IB2(i)^2+eta_IB3(i)^2));

end


