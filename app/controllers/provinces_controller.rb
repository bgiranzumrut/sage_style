class ProvincesController < ApplicationController
  def tax_rates
    province = Province.find(params[:id])
    subtotal = params[:subtotal].to_f

    gst = subtotal * province.gst_rate
    pst = subtotal * province.pst_rate
    hst = subtotal * province.hst_rate
    total = subtotal + gst + pst + hst

    render json: {
      gst: gst.round(2),
      pst: pst.round(2),
      hst: hst.round(2),
      total: total.round(2)
    }
  end
end
