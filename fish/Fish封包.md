Fish 封包<span id="標題"></span>
=========================

<a href="#說明">說明</a><br />
<a href="#初始資訊">初始資訊</a><br />
<a href="#進入漁場">進入漁場</a><br />
<a href="#漁場內通知玩家進入">漁場內通知玩家進入</a><br />
<a href="#漁場內通知玩家離開">漁場內通知玩家離開</a><br />
<a href="#出魚腳本">出魚腳本</a><br />
<a href="#設定押注乘數">設定押注乘數</a><br />
<a href="#射擊">射擊</a><br />
<a href="#擊中魚">擊中魚</a><br />
<a href="#金額變更">金額變更</a><br />
<a href="#技能數量變更">技能數量變更</a><br />
<a href="#使用技能">使用技能</a><br />
<a href="#技能影響範圍">技能影響範圍</a><br />
<a href="#技能的目標變更">技能的目標變更</a><br />
<a href="#NPC 的皮膚更換">NPC 的皮膚更換</a><br />
<a href="#NPC 時間調整 (或刪除)">NPC 時間調整 (或刪除)</a><br />
<a href="#列舉">列舉</a>

0. **初始資訊**<span id="初始資訊"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - SFishFieldSet
        - BetMultiples []int // 押注乘數列表
        - MinBalance   int64 // 最少需帶入金額
    - GtoCFishInit
        - Code int
        - // GtoCJoinGame 後 Server 會直接送這封包
        - MoneyFractionMultiple int             // 錢小數轉整數時要乘的倍數; 以整數型態保存, 轉為小數需除以此欄位
        - BetUnit               int64           // 押注單位 (錢); 押注乘數x押注單位=一發子彈的押注
        - FishFieldSets         []SFishFieldSet // 漁場設定列表
0. **進入漁場**<span id="進入漁場"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - SFishSeatInfo
        - SeatID      int   // 座位 ID
        - Balance     int64 // 金額 (錢)
        - BetMultiple int   // 押注乘數
    - CtoGFishEnterField
        - Code int
        - FieldIndex int // 漁場索引
    - GtoCFishEnterField
        - Code int
        - Result    int             // 結果 (錯誤碼)
        - SeatID    int             // 座位 ID
        - SkillNum  []int           // 技能個數; 0: 鎖定, 1: 冰凍, 2: 雷射
        - SeatInfos []SFishSeatInfo // 座位資訊列表
0. **漁場內通知玩家進入**<span id="漁場內通知玩家進入"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - GtoCFishPlayerJoin
        - Code int
        - SeatInfo SFishSeatInfo // 座位資訊
0. **離開漁場**<span id="離開漁場"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - CtoGFishLeaveField
        - Code int
0. **漁場內通知玩家離開**<span id="漁場內通知玩家離開"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - GtoCFishPlayerLeave
        - Code int
        - SeatID int // 座位 ID
0. **出魚腳本**<span id="出魚腳本"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - SFishNPCInfo
        - Type         int     // <a href="#出魚資訊類型">出魚資訊類型</a>
        - NpcID        int64   // NPC 識別碼
        - ParentNpcID  int64   // 軌跡錨點的 NPC
        - ActiveTime   int64   // 開始活動時間 / 魚潮開始時間 / 技能施放時間
        - Speed        float64 // 速度
        - NPCNumber    int     // NPC 編號 / 魚潮編號
        - NPCMotion    int     // NPC 軌跡 / 魚潮:0=播放魚潮在附近, 1=清空魚場 / 技能編號
        - OffsetX      float64 // X 偏移
        - OffsetY      float64 // Y 偏移
        - OffsetZ      float64 // Z 偏移
        - LifeEnd      int64   // 壽命 (哪時結束)
        - NumberOfGift int     // 環繞物編號 (0表示無)
    - GtoCFishNewScript
        - NPCInfos []SFishNPCInfo // 出魚資訊列表
0. **設定押注乘數**<span id="設定押注乘數"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - CtoGFishSetBetMultiple
        - Code int
        - BetMultiple int // 押注乘數
    - GtoCFishSetBetMultiple
        - Code int
        - Result      int // 結果 (錯誤碼)
        - SeatID      int // 座位 ID
        - BetMultiple int // 押注乘數
0. **射擊**<span id="射擊"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - CtoGFishShooting
        - Code int
        - // Server 不處理, 前端表演用
        - BulletID int64   // 子彈 ID / 射擊時間
        - Angle    float64 // 角度，若無可免填
        - NpcID    int64   // NPC 識別碼 (鎖定用)
    - GtoCFishShooting
        - Code int
        - SeatID   int     // 座位 ID
        - BulletID int64   // 子彈 ID / 射擊時間
        - Angle    float64 // 角度，若無可免填
        - NpcID    int64   // NPC 識別碼 (鎖定用, 穿越任何 NPC 直接命中此目標)
0. **擊中魚**<span id="擊中魚"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- SFishBHitInfo
		- NpcID int64	// NPC 識別碼
		- X     int		// 命中的座標X
		- Y     int		// 命中的座標Y
    - CtoGFishHit
        - Code int
        - BulletID	int64			// 子彈 ID
        - HitInfos	[]SFishBHitInfo // 命中資訊列表
0. **金額變更**<span id="金額變更"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - GtoCFishUpdateBalance
        - Code int
        - SeatID        int   // 座位 ID
        - Event         int   // <a href="#事件類型">事件類型</a>
        - BalanceAdjust int64 // 若為負值則表示扣錢
        - NpcID         int64 // NPC 識別碼
        - BulletID      int64 // 子彈 ID
		- X              int  // 命中的座標X
		- Y              int  // 命中的座標Y
0. **技能數量變更**<span id="技能數量變更"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - GtoCFishUpdateSkillNum
        - Code int
        - SeatID         int   // 座位 ID
        - Event          int   // <a href="#事件類型">事件類型</a>
        - SkillID        int   // 技能編號
        - SkillNumAdjust int64 // 若為負值則表示扣除
        - NpcID          int64 // NPC 識別碼
        - BulletID       int64 // 子彈 ID
		- X              int   // 命中的座標X
		- Y              int   // 命中的座標Y
0. **使用技能**<span id="使用技能"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - CtoGFishCastSkill
        - Code int
		- SkillID  int     // <a href="#技能編號">技能編號</a>
        - BulletID int64   // 子彈 ID / 技能施放時間
        - NpcID    int64   // NPC識別碼, 如果技能必須指定 NPC, 則將 NPCID 放入此欄位, 若無可免填
        - Angle    float64 // 角度, 若無可免填
    - SFishNPCLifeAdjustment
        - NpcID            int64 // NPC 識別碼
        - ActiveTimeBefore int64 // 原本的時間
        - ActiveTime       int64 // 開始活動時間 / 魚潮開始時間 / 技能施放時間
        - LifeEnd          int64 // 壽命 (哪時結束), Client 需比對目前時間, 若伺服器希望刪除此 NPC, 則會將更新後的時間設為已到期 (比目前時間還早的時間)
    - GtoCFishCastSkill
        - Code int
        - SeatID             int                      // 座位 ID
        - SkillID            int                      // <a href="#技能編號">技能編號</a>
        - BulletID           int64                    // 子彈 ID / 技能施放時間
        - NpcID              int64                    // NPC識別碼, 如果技能必須指定 NPC, 則將 NPCID 放入此欄位, 若無可免填
        - Angle              float64                  // 角度, 若無可免填
        - NPCLifeAdjustments []SFishNPCLifeAdjustment // 只要此欄位存在 (陣列長度不為 0), 程式就須處理
0. **技能影響範圍**<span id="技能影響範圍"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - CtoGFishSkillAreaOfEffect
        - Code int
        - BulletID         int64				// 子彈 ID / 技能施放時間
        - HitInfoMainTargets []SFishBHitInfo	// 命中資訊列表，主打擊目標，此列表所受傷害較重
        - HitInfoSub         []SFishBHitInfo	// 命中資訊列表，次打擊目標，此列表所受傷害較輕微
0. **技能的目標變更**<span id="技能的目標變更"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - CtoGFishSkillTargetChanged
        - Code int
        - SkillID         int     // <a href="#技能編號">技能編號</a>
        - BulletIDBefore  int64   // 技能施放時的時間
        - BulletIDChanged int64   // 變更新目標的時間 (從此後也會用新的時間來當 ID)
        - NpcID           int64   // NPC 識別碼, 如果技能必須指定 NPC, 則將 NPCID 放入此欄位, 若無可免填
        - Angle           float64 // 角度, 若無可免填
    - GtoCFishSkillTargetChanged
        - Code int
        - SeatID             int                      // 座位 ID
        - SkillID            int                      // <a href="#技能編號">技能編號</a>
        - BulletIDBefore     int64                    // 技能施放時的時間
        - BulletIDChanged    int64                    // 變更新目標的時間 (從此後也會用新的時間來當 ID)
        - NpcID              int64                    // NPC 識別碼, 如果技能必須指定 NPC, 則將 NPCID 放入此欄位, 若無可免填
        - Angle              float64                  // 角度, 若無可免填
0. **NPC 的皮膚更換**<span id="NPC 的皮膚更換"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - GtoCFishNpcSkinChanged
        - Code int
        - NpcID   int64 // NPC 識別碼
        - NewSkin int   // 新的皮膚代號
0. **NPC 時間調整 (或刪除)**<span id="NPC 時間調整 (或刪除)"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - GtoCNPCLifeChanged
        - Code int
        - NPCLifeAdjustments []SFishNPCLifeAdjustment // 只要此欄位存在 (陣列長度不為 0), 程式就須處理
0. **列舉**<span id="列舉"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
    - 封包編號<span id="封包編號"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
		- GtoCFishInit               = 12001
		- CtoGFishEnterField         = 12002
		- GtoCFishEnterField         = 12003
		- GtoCFishPlayerJoin         = 12004
		- CtoGFishLeaveField         = 12005
		- GtoCFishPlayerLeave        = 12006
		- GtoCFishNewScript          = 12007
		- CtoGFishSetBetMultiple     = 12008
		- GtoCFishSetBetMultiple     = 12009
		- CtoGFishShooting           = 12010
		- GtoCFishShooting           = 12011
		- CtoGFishHit                = 12012
		- GtoCFishUpdateBalance      = 12013
		- GtoCFishUpdateSkillNum     = 12014
		- CtoGFishCastSkill          = 12015
		- GtoCFishCastSkill          = 12016
		- CtoGFishSkillAreaOfEffect  = 12017
		- CtoGFishSkillTargetChanged = 12018
		- GtoCFishSkillTargetChanged = 12019
		- GtoCFishNpcSkinChanged     = 12020
		- GtoCNPCLifeChanged         = 12021
    - 出魚資訊類型<span id="出魚資訊類型"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
        - NPCACTIVE    = 0 // 一般的魚進場
        - BOSSNOTIFY   = 1 // 撥放BOSS出場字幕
        - NPCBOSS      = 2 // BOOS進場
        - NPCBOSSLEAVE = 3 // BOOS離場軌跡
        - FISHTIDE     = 4 // 魚潮來了(通常都會撥放xxx魚潮正在附近)
        - FISHTIDENPC  = 5 // 魚潮的魚
        - NPCSKILL     = 6 // NPC技能施放，此時 NPC_Motion 欄位應該解釋為技能編號
        - NPCMOTIONCHG = 7 // NPC軌跡重新設定，所有欄位定義同 NPCINFOTYPE_NPCACTIVE
    - 事件類型<span id="事件類型"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
        - SYSTEM     = 0; // Client 直接調整金幣值即可
        - KILLNPC    = 1; // NpcID 會指出哪隻 NPC 被殺
        - HITBONUS   = 2; // NpcID 會指出哪隻 NPC 發放的獎勵
        - ROULETTE   = 3; // NpcID 會指出哪隻 NPC 發出的輪盤
        - ENERGYBAR  = 4; // NpcID 固定為 0
        - LEVELBONUS = 5; // NpcID 會填入哪個等級所送的獎勵
    - 技能編號<span id="技能編號"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
        - NONE   = 0; // 基本上抓到這個值就是出錯了, 伺服器也會用這個值來標示子彈為普通
        - FIRST  = 1; // 程式定位用
        - LOCK   = 1; // 鎖定
        - FREEZE = 2; // 冰凍
        - LASER  = 3; // 雷射
        - FOG    = 4; // 煙霧
        - LIMIT  = 5; // 用來檢查錯誤用, 大於等於此值即為錯誤
