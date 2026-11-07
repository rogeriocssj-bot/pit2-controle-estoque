export const KEY = 'pit2-estoque-v1';
const now = () => new Date().toISOString();
const seedProducts = [
 ['P001','Café torrado 500g','Alimentos',18.9,12,30],['P002','Arroz tipo 1 5kg','Alimentos',29.5,8,18],['P003','Açúcar refinado 1kg','Alimentos',5.7,10,10],['P004','Água mineral 500ml','Bebidas',2.5,24,48],
 ['P005','Refrigerante cola 2L','Bebidas',9.9,10,7],['P006','Detergente neutro','Limpeza',3.8,15,22],['P007','Papel toalha','Limpeza',7.4,8,0],['P008','Caderno universitário','Papelaria',16.9,10,14],
 ['P009','Caneta azul','Papelaria',2.9,20,55],['P010','Pilhas AA (4 un.)','Eletrônicos',14.5,6,4],['P011','Lâmpada LED 9W','Eletrônicos',12.9,5,17],['P012','Sacola reutilizável','Utilidades',8.5,10,9]
].map(([code,name,category,price,min,stock],i)=>({id:`prod-${i+1}`,code,name,description:`Produto demonstrativo: ${name}.`,category,price,minStock:min,initialStock:stock,active:true}));
const seedMovements = [
 ['prod-1','entrada',10,'2026-10-05T09:00:00.000Z'],['prod-2','saida',3,'2026-10-12T14:15:00.000Z'],['prod-5','saida',4,'2026-10-18T10:30:00.000Z'],['prod-10','saida',2,'2026-10-22T16:40:00.000Z'],['prod-7','saida',8,'2026-10-25T11:00:00.000Z'],['prod-4','entrada',24,'2026-11-01T08:20:00.000Z']
].map(([productId,type,quantity,date],i)=>({id:`mov-${i+1}`,productId,type,quantity,date,note:'Movimentação demonstrativa',user:'Mariana Costa'}));
export function seed(){ return {version:1,products:seedProducts,movements:seedMovements,session:null}; }
export function valid(s){return s && Array.isArray(s.products) && Array.isArray(s.movements) && s.version===1;}
export function load(){try{const raw=localStorage.getItem(KEY); if(!raw)return seed(); const data=JSON.parse(raw); return valid(data)?data:seed();}catch{return seed();}}
export function save(state){try{localStorage.setItem(KEY,JSON.stringify(state));return true;}catch{return false;}}
export function restore(){const state=seed(); save(state); return state;}
export function id(prefix){return `${prefix}-${Date.now()}-${Math.random().toString(36).slice(2,7)}`;}
export const dateNow = now;
