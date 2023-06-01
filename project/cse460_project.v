module cse460_project(clk,a,b,c,opcode,zf,cf,sf);


input [4:1]a,b ;
input [3:1]opcode;
input clk;
reg [2:1]temp;//temp for storing 1 bit operation value
reg cartemp;//carry temporary
reg [3:1]bc;//bit count opcode


output reg [4:1]c;
output reg sf,cf,zf;


parameter v0=3'b000,v1=3'b001,v2=3'b010,v3=3'b011,v4=3'b100,v5=3'b101;// for simplicity we are assingin parameters.




always @(posedge clk)
 begin
        //--------------------------------------------------------
        if (opcode==v0)//reset
        begin
        bc=v1;
        temp=2'b00;
        cartemp=0;


        end
        
        
        //-----------------------------------------------------------------
        if (opcode==v1)//xor
        begin
         if(bc==v1)//first bit operation
          begin
          
           c=4'b0000;//initially all 0
           sf=0;
           cf=0;
           zf=0;
           
           c[1]=a[1]^b[1];
           bc=v2;
         
          end
         else begin
         
                if(bc==v2)//second bit operation
                        begin
                           
                           c[2]=a[2]^b[2];
                           bc=v3;
                  
                        end
                else 
                begin
                        if(bc==v3)//third bit operation
                          begin
                           c[3]=a[3]^b[3];
                           bc=v4;
                          
                          end
                        
                        else
                        
                                begin
                                        if(bc==v4)//fourth bit operation
                                          begin
                                           c[4]=a[4]^b[4];
                                           bc=v0;//for no more operation
                                           
                                           
                                           if(c==4'b0000)//res 0 hole zf 1
                                                zf=1;
                                                
                                           if (c[4]==1)// 4th bit 1 hole sf 1
                                                sf=1;
                                                
                                          
                                          end
                                end
                        
                end
         
         end


        end
        
        
        
        
        //------------------------------------------------------------------
        
        if (opcode==v2)//add
        begin
         if(bc==v1)//first bit operation
          begin
          
           c=4'b0000;//initially all 0
           sf=0;
           cf=0;
           zf=0;
           
           temp=a[1]+b[1];
           c[1]=temp[1];
           cartemp=temp[2];
           bc=v2;
         
          end
         else begin
         
                if(bc==v2)//second bit operation
                        begin
                           
                           temp=a[2]+b[2]+cartemp;
                           c[2]=temp[1];
                           cartemp=temp[2];
                           bc=v3;
                  
                        end
                else 
                begin
                        if(bc==v3)//third bit operation
                          begin
                           temp=a[3]+b[3]+cartemp;
                           c[3]=temp[1];
                           cartemp=temp[2];
                           bc=v4;
                          
                          end
                        
                        else
                        
                                begin
                                        if(bc==v4)//fourth bit operation
                                          begin
                                           temp=a[4]+b[4]+cartemp;
                                           c[4]=temp[1];
                                           cartemp=temp[2];
                                           bc=v0;
                                           
                                           if(c==4'b0000)//res 0 hole zf 1
                                                zf=1;
                                                
                                           if (cartemp==1)//last carry 1 hole cf 1
                                            cf=1;
                                           
                                           if (c[4]==1)// 4th bit 1 hole sf 1
                                                sf=1;
                                                
                                          
                                          end
                                end
                        
         
                end
                 
         end
        


        end
        
        
        
        
//------------------------------------------------------------------------        
        
        if (opcode==v3)//xnor
        begin
         if(bc==v1)//first bit operation
          begin
          
           c=4'b0000;//initially all 0
           sf=0;
           cf=0;
           zf=0;
           
           if ((a[1]^b[1])==1)//Xnor from xor
                begin
                        c[1]=1'b0;
                end
                
                else
                 begin
                        c[1]=1'b1;
             end
           
           bc=v2;
         
          end
         else begin
         
                if(bc==v2)//second bit operation
                        begin
                           
                           if ((a[2]^b[2])==1)
                                begin
                                        c[2]=1'b0;
                                end
                                
                           else
                                 begin
                                        c[2]=1'b1;
                                 end
           
                           bc=v3;
                  
                        end
                else 
                begin
                        if(bc==v3)//third bit operation
                          begin
                           if ((a[3]^b[3])==1)   // As xnor is opposite of xor. so we are just flipping the value after calculating xor.
                                begin
                                        c[3]=1'b0;
                                end
                                
                           else
                                 begin
                                        c[3]=1'b1;
                                 end
                           
                           bc=v4;
                          
                          end
                        
                        else
                        
                                begin
                                        if(bc==v4)//fourth bit operation
                                          begin
                                           if ((a[4]^b[4])==1)
                                                begin
                                                        c[4]=1'b0;
                                                end
                                                
                                           else
                                                 begin
                                                        c[4]=1'b1;
                                                 end
           
                                           bc=v0;//for no more operation
                                           
                                           
                                           if(c==4'b0000)//res 0 hole zf 1
                                                zf=1;
                                                
                                           if (c[4]==1)// 4th bit 1 hole sf 1
                                                sf=1;
                                                
                                          
                                          end
                                end
                        
                end
         
         end


        end
//-----------------------------------------------------------------------------------        
        if (opcode==v4)//sub
        begin
         if(bc==v1)//first bit operation
          begin
          
           c=4'b0000;//initially all 0
           sf=0;
           cf=0;
           zf=0;
           
           temp=a[1]-b[1];
           c[1]=temp[1];
           cartemp=temp[2];
           bc=v2;
         
          end
         else begin
         
                if(bc==v2)//second bit operation
                        begin
                           
                           temp=a[2]-b[2]-cartemp;
                           c[2]=temp[1];
                           cartemp=temp[2];
                           bc=v3;
                  
                        end
                else 
                begin
                        if(bc==v3)//third bit operation
                          begin
                           temp=a[3]-b[3]-cartemp;
                           c[3]=temp[1];
                           cartemp=temp[2];
                           bc=v4;
                          
                          end
                        
                        else
                        
                                begin
                                        if(bc==v4)//fourth bit operation
                                          begin
                                           temp=a[4]-b[4]-cartemp;
                                           c[4]=temp[1];
                                           cartemp=temp[2];
                                           bc=v0;
                                           
                                           if(c==4'b0000)//res 0 hole zf 1
                                                zf=1;
                                                
                                           if (cartemp==1)//last carry 1 hole cf 1
                                            cf=1;
                                           
                                           if (c[4]==1)// 4th bit 1 hole sf 1
                                                sf=1;
                                                
                                          
                                          end
                                end
                        
         
                end
                 
         end
        


        end
        
        
        






 end










endmodule
