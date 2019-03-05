package com.gd.dao.common;

import com.gd.domain.video.Channel;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 郄梦岩 on 2017/10/19.
 */
@Repository("channelDao")
public interface IChannelDao {
    //添加通道
    @Insert("<script>INSERT INTO tbl_channel (ChannelID,CamID,NvrID,NvrChannelID,FrameRate,BitRateType,BitRate,PlayUrl," +
            "Resolution,AudioFlag,AudioEncoderType,AudioBitRate,AudioSampleRate,UseType) values (#{ChannelID},#{CamID},#{NvrID}," +
            "#{NvrChannelID},#{FrameRate},#{BitRateType},#{BitRate},#{PlayUrl},#{Resolution},#{AudioFlag},#{AudioEncoderType},#{AudioBitRate},#{AudioSampleRate},#{UseType})</script>")
    void addForObject(Channel channel);

    //查询所有通道
    @Select("<script>SELECT * FROM tbl_channel WHERE CamID != 0 order by ChannelID DESC</script>")
    List<Channel> queryForObject();

    //更新通道信息
    @Update("<script>UPDATE tbl_channel SET CamID=#{CamID},FrameRate=#{FrameRate}," +
            "BitRateType=#{BitRateType},BitRate=#{BitRate},PlayUrl=#{PlayUrl},Resolution=#{Resolution},AudioFlag=#{AudioFlag},AudioEncoderType=#{AudioEncoderType}," +
            "AudioBitRate=#{AudioBitRate},AudioSampleRate=#{AudioSampleRate},UseType=#{UseType} WHERE NvrID=#{NvrID} and NvrChannelID=#{NvrChannelID} </script>")
    void updateForObject(Channel channel);

    //删除通道信息
    @Update("<script>UPDATE tbl_channel SET FrameRate=0," +
            "BitRateType=0,BitRate=0,PlayUrl='null',Resolution=0,AudioFlag=0,AudioEncoderType=0," +
            "AudioBitRate=0,AudioSampleRate=0,UseType=0 WHERE ChannelID=#{ChannelID} </script>")
    void deleteForObject(Channel channel);

    //根据NVRID删除通道信息
    @Delete("<script>DELETE FROM tbl_channel WHERE NvrID=#{NvrID}</script>")
    void delete1ForObject(Channel channel);
    @Delete("<script>UPDATE tbl_channel SET  PlayUrl='null',UseType=0 WHERE NvrID=#{NvrID} AND CamID=#{CamID} AND NvrChannelID=#{NvrChannelID}</script>")
    void UpdateOldChannel(Channel channel);
    //查询通道未被使用的设备通道号
    @Select("<script> SELECT NvrChannelID FROM tbl_channel where NvrID=#{CamID} and PlayUrl='null'</script>")
    List<Integer> queryForChannelID(Channel channel);

    @Select("<script> SELECT count(*) from tbl_channel where CamID=#{CamID}</script>")
    Integer queryForCameraId(Channel channel);

    @Update("<script>UPDATE tbl_channel SET PlayUrl=#{PlayUrl} WHERE NvrID=#{NvrID} AND NvrChannelID=#{NvrChannelID} AND CamID=#{CamID}</script>")
    void updateForPlayUrl(Channel channel);

    @Select("<script>SELECT ResType FROM tbl_res_attr WHERE ResID=#{id}</script>")
    String selectNvrID(String id);

    @Update("<script>UPDATE tbl_channel SET PlayUrl='null',UseType=0 WHERE CamID=#{CamID} </script>")
    void updateForObject0(Channel channel);

}
