import streamlit as st
import pandas as pd
import numpy as np

# 页面配置
st.set_page_config(page_title="本科报考热度智能分析平台", layout="wide")
st.markdown("# 本科报考热度智能分析平台")
st.divider()

# 两栏布局：左侧输入区 + 右侧结果区
col_left, col_right = st.columns([1, 2.5], gap="large")

# -------------------------- 左侧：参数输入区 --------------------------
with col_left:
    st.subheader("参数输入")

    # 1. 分数滑动条（修复label警告）
    st.markdown("分数")
    score = st.slider(
        "你的高考分数",
        min_value=200,
        max_value=750,
        value=550,
        label_visibility="collapsed"
    )

    # 2. 省份下拉框
    st.markdown("省份")
    province = st.selectbox(
        "选择省份",
        ["浙江省", "江苏省", "广东省", "山东省"],
        label_visibility="collapsed"
    )

    # 3. 专业输入框
    st.markdown("专业类别")
    major = st.text_input(
        "输入专业类别",
        value="工学",
        label_visibility="collapsed"
    )

    # 4. 分析按钮（绿色主按钮）
    run_btn = st.button("分析", type="primary", use_container_width=True)

# -------------------------- 右侧：结果展示区 --------------------------
with col_right:
    if run_btn:
        with st.spinner("正在生成结果..."):
            # 模拟预测数据
            result = pd.DataFrame({
                "序号": [1, 2, 3, 4],
                "院校名称": ["浙江大学", "浙江工业大学", "杭州电子科技大学", "宁波大学"],
                "专业": ["计算机科学与技术", "软件工程", "电子信息工程", "机械设计"],
                "预测热度": np.round(np.random.uniform(8.5, 9.9, 4), 2),
                "状态": ["冲刺", "稳妥", "稳妥", "保底"]
            })

            # 1. 符合条件院校专业预测表格
            st.subheader("符合条件院校专业预测")
            st.dataframe(result[["序号", "院校名称", "专业", "预测热度"]], use_container_width=True)

            # 2. 冲稳保志愿推荐
            st.subheader("志愿推荐")
            col1, col2, col3 = st.columns(3)
            with col1:
                st.button("冲刺志愿", use_container_width=True)
            with col2:
                st.button("稳妥志愿", type="secondary", use_container_width=True)
            with col3:
                st.button("保底志愿", use_container_width=True)
    else:
        st.info("👈 请在左侧输入分数、省份和专业，点击「分析」按钮生成结果")
