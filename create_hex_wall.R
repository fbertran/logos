library(magick)  
alllogos <- image_read(list.files()[grep(".png$",list.files(),fixed = FALSE)])
image_montage(alllogos, geometry = 'x100+10+10', tile = '4x4', bg = 'none', shadow = TRUE)




source("hexwall.R")
undebug(hexwall)
aa4 <- hexwall(path = "pngs", sticker_row_size = 4, sticker_width = 200, sort_mode="filename")
aa4
image_write(aa4,path="hexwall_1.png", format = "png")

aa5 <- hexwall(path = "pngs", sticker_row_size = 5, sticker_width = 200, sort_mode="filename")
aa5
image_write(aa5,path="hexwall_2.png", format = "png")

aa6 <- hexwall(path = "pngs", sticker_row_size = 6, sticker_width = 200, sort_mode="filename")
aa6
image_write(aa6,path="hexwall_3.png", format = "png")


source("hexwall.R")
undebug(hexwall)
aa4 <- hexwall(path = "pngs", sticker_row_size = 4, sticker_width = 200, sort_mode="filename")
aa4
image_write(aa4,path="hexwall_1_small.png", format = "png")

aa5 <- hexwall(path = "pngs", sticker_row_size = 5, sticker_width = 200, sort_mode="filename")
aa5
image_write(aa5,path="hexwall_2_small.png", format = "png")

aa6 <- hexwall(path = "pngs", sticker_row_size = 6, sticker_width = 200, sort_mode="filename")
aa6
image_write(aa6,path="hexwall_3_small.png", format = "png")


sticker_row_size = 3
stickers<-alllogos

if(is.null(coords)){
  # Arrange rows of stickers into images
  sticker_col_size <- ceiling(length(stickers)/(sticker_row_size))
  row_lens <- rep(c(sticker_row_size,sticker_row_size-1), length.out=sticker_col_size)
  row_lens[length(row_lens)] <- row_lens[length(row_lens)]  - (length(stickers) - sum(row_lens))
  sticker_rows <- map2(row_lens, cumsum(row_lens),
                       ~ seq(.y-.x+1, by = 1, length.out = .x)) 
  
  %>%
    map(~ stickers[.x] %>%
          invoke(c, .) %>%
          image_append)
  
  # Add stickers to canvas
  canvas <- image_blank(sticker_row_size*sticker_width, 
                        sticker_height + (sticker_col_size-1)*sticker_height/1.33526, "white")
  reduce2(sticker_rows, seq_along(sticker_rows), 
          ~ image_composite(
            ..1, ..2,
            offset = paste0("+", ((..3-1)%%2)*sticker_width/2, "+", round((..3-1)*sticker_height/1.33526))
          ),
          .init = canvas)
}
