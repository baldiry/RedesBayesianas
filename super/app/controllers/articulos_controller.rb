class ArticulosController < ApplicationController
  before_action :set_articulo, only: [:show, :edit, :update, :destroy]
arregloResultado=[]
  def calculaCoincidencia(entrada,base)

#Nota: las entradas deben ser en minusculas
entradaMinusculas = entrada.downcase

entradaArreglo = entradaMinusculas.split(" ")

entradaBusqueda = entradaArreglo


#base =[

 # ["Estereo 1200 watts","estereo","electronica","sonido","audio"],
 # ["Televisor 50 pulgadas","electronica","televisor"],
 # ["Cloralex desinfectante","limpieza","hogar"],
 # ["cepillo dental","hogar","salud","higiene"],
 # ["Shampoo caprice","higiene","bano","hogar"],
 # ["Aceite","capullo","1","litro","hogar","cocina","alimento"],
 # ["Tomate rojo","rojo","verduras","cocina","alimento"],
 # ["Cebolla","verduras","cocina","alimento"],
 # ["Manzana roja","manzana","roja","fruta","alimento"],
  #["Platano","platano","fruta","alimento"],
 # ["Leche","lala","lacteos","alimento","bebida"],
  #["Refresco coca cola","bebida","refresco"],
  #["Arroz","cocina","alimento","integral"]
  #["Arroz","cocina","alimento","blanco"]

  #]


# Determines how similar a pair of sets are
#puts Jaccard.closest_to(a, [c, x, b,d,e])

#el coeficiente es un numero que se calcula con una formulade union e interseccion de conjuntos

# si el coeficiente es mayor a 0.20 debe ser una opcion valida
    contador=0
    arreglo=[]

    for i in base
      if Jaccard.coefficient(entradaBusqueda,i) > 0
        arreglo[contador] =[Jaccard.coefficient(entradaBusqueda,i),i[0]]
        contador+=1
        
      end
    end

#se ordena y se invierte el arreglo bidimensional
arreglOrdenado = arreglo.sort.reverse

    contadorDos =0
    

    #se volcara solo la descripcion de la busqueda en el nuevo arreglo
    for k in arreglOrdenado
      #se obtiene la segunda columna del arreglo, osea los nombre
      #con el 0 se obtiene el valor
      arregloResultado[contadorDos] = arreglOrdenado[contadorDos][1]
      contadorDos+=1
    end

#resultado
#arregloResultado
    

  end




  # GET /articulos
  # GET /articulos.json
  def index
       ## calculaCoincidencia(params[:entrada])
       arregloSalida=[];
       contador=0;
       baseTags=[];
       descripcion="";
       baseGeneral=[];

       entrada = params[:entrada];
       entradaMinusculas = entrada.downcase

        entradaArreglo = entradaMinusculas.split(" ")

      entradaBusqueda = entradaArreglo

       Articulo.find_each do |a|
        cadenaTags=a.tags;
        baseTags=cadenaTags.split(",");
        descripcion=a.descripcion;

        baseTags[baseTags.length]=descripcion;

        if Jaccard.coefficient(entradaBusqueda,baseTags)  > 0

          arregloSalida[contador] =descripcion;
       contador+=1

       end
        
       end

       @resultado= arregloSalida;
       @entrada

  end

  # GET /articulos/1
  # GET /articulos/1.json
  def show
  end

  # GET /articulos/new
  def new
    @articulo = Articulo.new
  end

  # GET /articulos/1/edit
  def edit
  end

  # POST /articulos
  # POST /articulos.json
  def create

    
  

    #calculaCoincidencia(@entradaBusqueda)

  #  @articulo = Articulo.new(articulo_params)

   # respond_to do |format|
    #  if @articulo.save
     #   format.html { redirect_to @articulo, notice: 'Articulo was successfully created.' }
      #  format.json { render :show, status: :created, location: @articulo }
      #else
      #  format.html { render :new }
      #  format.json { render json: @articulo.errors, status: :unprocessable_entity }
      #end
    #end
  end

  # PATCH/PUT /articulos/1
  # PATCH/PUT /articulos/1.json
  def update
    respond_to do |format|
      if @articulo.update(articulo_params)
        format.html { redirect_to @articulo, notice: 'Articulo was successfully updated.' }
        format.json { render :show, status: :ok, location: @articulo }
      else
        format.html { render :edit }
        format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articulos/1
  # DELETE /articulos/1.json
  def destroy
    @articulo.destroy
    respond_to do |format|
      format.html { redirect_to articulos_url, notice: 'Articulo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_articulo
      @articulo = Articulo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def articulo_params
      params.require(:articulo).permit(:descripcion, :precio, :tags)
    end
end
