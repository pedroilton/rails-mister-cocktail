class DosesController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    if params[:dose][:ingredient_id] != ''
      @dose = Dose.new(dose_params)
      @dose.cocktail = @cocktail
      @dose.ingredient = Ingredient.find(params[:dose][:ingredient_id])
      test_dose_save
    else
      redirect_to @cocktail, notice: 'All dose fields must be filled!'
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy
    redirect_to @cocktail
  end

  private

  def dose_params
    params.require(:dose).permit(:description)
  end

  def test_dose_save
    if @dose.save
      redirect_to @cocktail
    else
      redirect_to @cocktail, notice: 'All dose fields must be filled!'
    end
  end
end

# def create
#   if params[:dose][:ingredient_id] != ''
#     @cocktail = Cocktail.find(params[:cocktail_id])
#     @ingredient = Ingredient.find(params[:dose][:ingredient_id])
#     @dose = Dose.new(dose_params)
#     @dose.cocktail = @cocktail
#     @dose.ingredient = @ingredient
#     @dose.save ? redirect_to(@cocktail) : render(:new)
#   else
#     render :new
#   end
# end
